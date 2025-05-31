# Quirky NPC Service 🎲

![Ruby](https://img.shields.io/badge/Ruby-3.2.4-red?logo=ruby)
![Rails](https://img.shields.io/badge/Rails-7.1.5.1-cc0000?logo=rubyonrails)
![PostgreSQL](https://img.shields.io/badge/PostgreSQL-15-blue?logo=postgresql)
![Coverage](https://img.shields.io/badge/coverage-94.94%25-brightgreen)
[![Swagger](https://img.shields.io/badge/docs-Swagger-blue?logo=swagger)](https://quirky-npc-service.onrender.com/api-docs)
[![Deploy](https://img.shields.io/badge/deployed-Render-5b9bd5?logo=render)](https://quirky-npc-service.onrender.com)
![Made with Magic](https://img.shields.io/badge/Made%20with-Magic%E2%9C%A8-purple)
![NPC Approved](https://img.shields.io/badge/NPCs-Quirky%20AF-ff69b4)

An API-only Ruby on Rails app that generates and manages silly, Dungeons & Dragons-inspired NPCs with quirky names, jobs, moods, and traits.

> 🧠 Perfect for D&D game masters, fantasy writers, or anyone who enjoys a good goblin joke.

---

## 🚀 Features

- Generate fully procedural NPCs (`POST /npcs/generate`)
- Save, update, delete, and list NPCs
- Random NPC endpoint (`GET /npcs/random`)
- Filtering by species and alignment
- Pagination with [Pagy](https://github.com/ddnexus/pagy)
- Friendly JSON error handling
- Auto-generated API documentation via Swagger (Rswag)
- JSON responses with [ActiveModelSerializers](https://github.com/rails-api/active_model_serializers)

---

## 📘 API Documentation

> 🔗 Explore the API: [`https://quirky-npc-service.onrender.com/api-docs/index.html`](https://quirky-npc-service.onrender.com/api-docs/index.html)

The **Swagger UI** provides a live, interactive interface to test and understand all available endpoints of the Quirky NPC Service.

### 🔍 What’s Included:

- **All available endpoints**, grouped by feature (e.g., NPC management, random generation)
- **Request & response examples** for common use cases
- **Error responses** and validation details (`400`, `404`, `422`, `429`)
- **Filterable parameters** like `species`, `alignment`, `mood`, `job`, and `quirk`
- **Response schemas** with real example NPCs and pagination metadata
- **Enum value listings** for structured fields (e.g., all D&D alignments)
- Optional: **Rate limit documentation** (if enabled via `Rack::Attack`)

### 🧪 Try it Out

You can make real requests directly from the docs — great for testing your frontend integration or exploring available features.

---

## 📊 Test Coverage

We use [SimpleCov](https://github.com/simplecov-ruby/simplecov) to track test coverage.

By default, coverage is **not generated** on every run.

To generate a report manually:

```bash
COVERAGE=true bundle exec rspec
```
![image](https://github.com/user-attachments/assets/fcaf0120-d08d-4fdd-a535-f76191296874)


---

## 🧙‍♂️ Example: Generated NPC
```json
{
  "name": "Tilda Fizzlepot",
  "job": "Potion Tester",
  "quirk": "Only speaks in rhymes",
  "mood": "Suspiciously friendly",
  "species": "Gnome",
  "alignment": "Chaotic Neutral"
}
```

## ✅ Tests

- ✅ Model validations and methods (`Npc`)
- ✅ NPC generator service (`NpcGeneratorService`)
- ✅ Serializer output (`NpcSerializer`)
- ✅ Full request/integration specs using `rswag`
- ✅ Global error handling:
  - `404` – Record not found
  - `400` – Missing required parameters
  - `422` – Invalid filter values

## 🪄 License

MIT — use freely, modify gleefully, and enjoy the chaos 🐉
