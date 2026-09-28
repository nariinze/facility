import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:facility/main.dart';

void main() {
  testWidgets('login, reserve an available facility, and return to list', (
    WidgetTester tester,
  ) async {
    await tester.pumpWidget(const MyApp());

    await tester.enterText(
      find.byKey(const Key('usernameField')),
      'Lucy Naibaho',
    );
    await tester.enterText(find.byKey(const Key('passwordField')), '124240040');
    await tester.tap(find.byKey(const Key('loginButton')));
    await tester.pumpAndSettle();

    expect(find.text('Fasilitas Kampus'), findsOneWidget);
    await tester.tap(find.text('Ruang Diskusi A1'));
    await tester.pumpAndSettle();

    expect(find.text('Gedung FTI Lantai 2'), findsOneWidget);
    await tester.ensureVisible(find.byKey(const Key('reserveButton')));
    await tester.pumpAndSettle();
    await tester.tap(find.byKey(const Key('reserveButton')));
    await tester.pumpAndSettle();

    expect(find.text('✅ Reservasi Berhasil'), findsOneWidget);
    expect(find.byKey(const Key('reservationConfirmation')), findsOneWidget);
    await tester.ensureVisible(find.byKey(const Key('backToListButton')));
    await tester.pumpAndSettle();
    await tester.tap(find.byKey(const Key('backToListButton')));
    await tester.pumpAndSettle();
    expect(find.text('Fasilitas Kampus'), findsOneWidget);
  });

  testWidgets('invalid credentials show an error', (WidgetTester tester) async {
    await tester.pumpWidget(const MyApp());
    await tester.enterText(find.byKey(const Key('usernameField')), 'wrong');
    await tester.enterText(find.byKey(const Key('passwordField')), 'wrong');
    await tester.tap(find.byKey(const Key('loginButton')));
    await tester.pump();

    expect(find.text('Username atau password tidak sesuai.'), findsOneWidget);
    expect(find.text('CampusGo'), findsOneWidget);
  });
}
