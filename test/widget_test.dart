import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:http/testing.dart';
import 'package:myportofolio_mobile/main.dart';
import 'package:myportofolio_mobile/models/project.dart';
import 'package:myportofolio_mobile/services/api_client.dart';
import 'package:myportofolio_mobile/services/auth_state.dart';

void main() {
  test(
    'Project JSON serialization uses snake_case and excludes id on toJson',
    () {
      final json = <String, dynamic>{
        'id': '123e4567-e89b-12d3-a456-426614174000',
        'title': 'MyPortfolio Mobile',
        'description': 'Aplikasi portofolio mobile berbasis Flutter.',
        'tech_stack': 'Flutter, Django REST Framework',
        'project_url':
            'https://github.com/jocelinenadine-dev/myportofolio_mobile',
      };

      final project = Project.fromJson(json);
      expect(project.id, '123e4567-e89b-12d3-a456-426614174000');
      expect(project.title, 'MyPortfolio Mobile');
      expect(project.techStack, 'Flutter, Django REST Framework');
      expect(project.projectImageUrl, '');

      final encoded = project.toJson();
      expect(encoded.containsKey('id'), isFalse);
      expect(encoded['tech_stack'], 'Flutter, Django REST Framework');
      expect(
        encoded['project_url'],
        'https://github.com/jocelinenadine-dev/myportofolio_mobile',
      );
    },
  );

  test('ApiClient and AuthState handle login, getProjects, createProject, and logout', () async {
    final mockHttp = MockClient((request) async {
      if (request.url.path == '/api/v1/auth/token/' &&
          request.method == 'POST') {
        return http.Response(jsonEncode({'token': 'test-token-123'}), 200);
      }
      if (request.url.path == '/api/v1/projects/' && request.method == 'GET') {
        return http.Response(
          jsonEncode([
            {
              'id': 'proj-1',
              'title': 'Portfolio Web',
              'description': 'Personal web built with Django.',
              'tech_stack': 'Django, DRF',
              'project_url': 'https://example.com/portfolio',
              'project_image_url': '',
            },
          ]),
          200,
        );
      }
      if (request.url.path == '/api/v1/projects/' && request.method == 'POST') {
        expect(request.headers['Authorization'], 'Token test-token-123');
        final payload = jsonDecode(request.body) as Map<String, dynamic>;
        return http.Response(jsonEncode({'id': 'proj-2', ...payload}), 201);
      }
      if (request.url.path == '/api/v1/auth/logout/' &&
          request.method == 'POST') {
        expect(request.headers['Authorization'], 'Token test-token-123');
        return http.Response('', 204);
      }
      return http.Response('Not Found', 404);
    });

    final apiClient = ApiClient(
      client: mockHttp,
      baseUrl: 'http://localhost:8000',
    );
    final authState = AuthState(apiClient);

    expect(authState.isLoggedIn, isFalse);
    await authState.login('joceline', 'secret');
    expect(authState.isLoggedIn, isTrue);
    expect(authState.token, 'test-token-123');

    final projects = await apiClient.getProjects();
    expect(projects, hasLength(1));
    expect(projects.first.title, 'Portfolio Web');

    final created = await apiClient.createProject(
      const Project(
        title: 'Mobile App',
        description: 'Flutter client',
        techStack: 'Flutter',
        projectUrl: 'https://example.com/mobile',
      ),
      token: authState.token!,
    );
    expect(created.id, 'proj-2');
    expect(created.title, 'Mobile App');

    await authState.logout();
    expect(authState.isLoggedIn, isFalse);
    expect(authState.token, isNull);
  });

  testWidgets('MyPortfolio Mobile smoke, project list, and auth guard test', (
    WidgetTester tester,
  ) async {
    final mockHttp = MockClient((request) async {
      if (request.url.path == '/api/v1/projects/' && request.method == 'GET') {
        return http.Response(
          jsonEncode([
            {
              'id': 'proj-1',
              'title': 'Portfolio Mobile',
              'description': 'Integrated with Django REST Framework.',
              'tech_stack': 'Flutter, DRF',
              'project_url': 'https://example.com/project',
              'project_image_url': '',
            },
          ]),
          200,
        );
      }
      return http.Response('Not Found', 404);
    });

    final apiClient = ApiClient(
      client: mockHttp,
      baseUrl: 'http://localhost:8000',
    );
    await tester.pumpWidget(MyApp(apiClient: apiClient));

    // Memastikan halaman utama tampil beserta kartu identitas.
    expect(find.text('MyPortfolio'), findsOneWidget);
    expect(find.text('2506656835'), findsOneWidget);
    expect(find.text('Joceline Nadine Immanuella'), findsOneWidget);
    expect(find.text('PBP A'), findsOneWidget);

    // Membuka daftar proyek secara publik tanpa login.
    await tester.ensureVisible(find.text('Lihat Proyek'));
    await tester.pumpAndSettle();
    await tester.tap(find.text('Lihat Proyek'));
    await tester.pumpAndSettle();

    expect(find.text('Achievements: Projects'), findsOneWidget);
    expect(find.text('Portfolio Mobile'), findsOneWidget);

    // Mengetuk item proyek menuju ProjectDetailScreen.
    await tester.tap(find.text('Portfolio Mobile'));
    await tester.pumpAndSettle();
    expect(find.text('Integrated with Django REST Framework.'), findsOneWidget);
  });
}
