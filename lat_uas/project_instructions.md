# Instructions for AI Agent

You are assisting in building a Flutter mobile app called **TicketWave Mobile – Lite Version**.  
Use the context from `uas_context.md` to generate code.

## Rules

1. Use **pure Flutter + Supabase** only.
2. State management uses **StatefulWidget + setState()**. Do NOT use Provider, Riverpod, Bloc, Redux, etc.
3. Theme persistence must use **shared_preferences**.
4. Navigation must use `Navigator.push` and `Navigator.pop`.
5. All data must come from Supabase:
   - Auth: email/password
   - Events: table `events`
   - Orders: table `orders`
   - Profile image: Supabase Storage + `user_profiles`
6. Use clean folder structure as in `folder_structure.txt`.
7. Keep code modular and minimal (since exam time is limited).
8. Do not implement unnecessary features unless explicitly required by the exam context.

## Your Goals

- Scaffold pages quickly
- Implement essential logic
- Ensure app builds for APK and Web

## Expected Deliverables

- Complete Flutter codebase
- Ready-to-build state
- No errors when running `flutter run`
