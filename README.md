# ChatGuard

> Twitch moderation bot and management panel for streamers and their mod teams.

ChatGuard is an open source Flutter app that combines a real-time Twitch chat bot with a full moderation management panel. Define your own rules, manage your community members, track sanctions, and let the bot enforce moderation automatically — all from a single app on your PC or mobile device.

Built for any streamer, with no assumptions about your moderation style. Everything is configurable from scratch.

---

## Features

- 🤖 **Real-time Twitch bot** — connects to your chat via IRC/WebSocket and responds to commands instantly.
- 🛡 **8 built-in commands** — `!ban`, `!unban`, `!timeout`, `!warn`, `!rules`, `!strikes`, `!mods`, `!chatguard on/off`.
- ⚠️ **Automatic warn system** — configurable thresholds for auto-timeout and auto-ban when warn limits are reached.
- 📋 **Custom rules** — define your channel rules from scratch with name, description, severity and consequence.
- 👥 **Member management** — track registered users with their full sanction history.
- 📜 **Sanctions log** — complete history of all moderation actions with filters by type, user and date.
- 🔐 **Role-based permissions** — Owner, Admin and Moderator roles with granular command permissions.
- 🌗 **Dark and light theme** — dark by default, fully themeable.
- 💾 **Local-first** — all data stored locally with Drift (SQLite). No account required beyond Twitch OAuth.

---

## Roadmap

| Version | Highlights |
|---------|------------|
| **v1.0** | Twitch bot, 8 base commands, rules/members/sanctions CRUD, warn system, OAuth login, role system, local Drift storage |
| **v1.1** | Cloud sync with Turso, multi-device support, Admin/Moderator panel access, custom commands |
| **v1.2** | YouTube Live Chat integration, multi-channel support, moderation stats and reports |

---

## Tech Stack

- [Flutter](https://flutter.dev) — Android, iOS, Windows, macOS, Linux
- [Riverpod](https://riverpod.dev) — state management
- [Drift](https://drift.simonbinder.eu) — local SQLite database
- [web_socket_channel](https://pub.dev/packages/web_socket_channel) — Twitch IRC connection
- [go_router](https://pub.dev/packages/go_router) — declarative navigation
- [flutter_secure_storage](https://pub.dev/packages/flutter_secure_storage) — secure OAuth token storage
- Twitch Helix API — moderation actions (ban, unban, timeout)

---

## Getting Started

### Prerequisites

- Flutter SDK >= 3.x
- A Twitch account
- A registered Twitch application at [dev.twitch.tv](https://dev.twitch.tv) to obtain your `client_id` and `client_secret`

### Installation

```bash
git clone https://github.com/raulcatalinas/chatguard.git
cd chatguard
flutter pub get
```

### Configuration

Create a `.env` file at the root of the project:

```env
TWITCH_CLIENT_ID=your_client_id
TWITCH_CLIENT_SECRET=your_client_secret
TWITCH_REDIRECT_URI=http://localhost:8080/auth/callback
```

### Run

```bash
# Desktop (Windows)
flutter run -d windows

# Desktop (macOS)
flutter run -d macos

# Android
flutter run -d android

# iOS
flutter run -d ios
```

---

## Bot Commands

| Command | Syntax | Description |
|---------|--------|-------------|
| `!ban` | `!ban [user] [reason]` | Permanently bans a user |
| `!unban` | `!unban [user]` | Lifts a ban |
| `!timeout` | `!timeout [user] [seconds?] [reason?]` | Times out a user (default: 600s) |
| `!warn` | `!warn [user] [reason]` | Issues a warning. Auto-timeout/ban at configured thresholds |
| `!rules` | `!rules` | Posts the channel rules in chat |
| `!strikes` | `!strikes [user]` | Shows active sanctions for a user |
| `!mods` | `!mods` | Lists active moderators |
| `!chatguard` | `!chatguard on/off` | Activates or pauses the bot |

---

## Roles

| Role | Permissions |
|------|-------------|
| **Owner** | Full access to panel and all commands. Configures permissions for other roles. |
| **Admin** | Executes commands in chat based on Owner-configured permissions. *(Panel access in v1.1)* |
| **Moderator** | Executes commands in chat based on Owner-configured permissions. *(Panel access in v1.1)* |

---

## Contributing

Contributions are welcome. Please open an issue first to discuss what you'd like to change.

1. Fork the repository
2. Create your feature branch (`git checkout -b feat/your-feature`)
3. Commit your changes following [Conventional Commits](https://www.conventionalcommits.org)
4. Push to the branch (`git push origin feat/your-feature`)
5. Open a Pull Request

---

## License

MIT License © 2026 [Raul Catalinas](https://github.com/raulcatalinas)

See [LICENSE](./LICENSE) for full details.
