# Active MVP — School Management (Rails 8 + PostgreSQL 17)

Krótki opis: Prosty system do zarządzania miejscami, kursami i uczestnikami (Place → Course → Participant). Projekt zaprojektowany jako pełny, prosty fullstackowy przykład pokazujący umiejętności w Ruby on Rails, PostgreSQL, HTML/CSS i JavaScript.

Demo: `[LINK_DO_DEMO]`\
Repozytorium: `https://github.com/Siedlak2480/rails-courses-app`

---

## Co pokazuje projekt

- CRUD dla Place / Course / Participant
- Frontend: formularze, walidacja, dynamiczne filtrowanie kursów (Vanilla JS / opcjonalnie Stimulus)
- Asynchroniczne tworzenie uczestnika (AJAX) — demonstracja bez przeładowania strony
- Prosty background job (Sidekiq) — enqueue demo (opcjonalnie)
- Testy: RSpec (kilka przykładowych speców)

---

## Zrzuty ekranu (placeholders)

Umieść swoje obrazki w `docs/screenshots/` i podmieniaj poniższe placeholdery.

- **[SCREEN1(Homepage)]** — Widok główny / dashboard po zalogowaniu: lista miejsc (Places) z nawigacją i krótkim podsumowaniem (np. liczba kursów, liczba uczestników).
- **[SCREEN2(Places list)]** — Lista miejsc (Places index): pokazuje wszystkie miejsca, przyciski `Show`, `Edit`, `Delete` i button `New Place`.
- **[SCREEN3(Course list for a Place)]** — Widok pojedynczego Place (`Place#show`) z listą kursów powiązanych z danym miejscem; każdy kurs ma link do strony kursu.
- **[SCREEN4(Course show + Participants)]** — Widok kursu (`Course#show`): lista uczestników, przycisk `New Participant`, pokazanie walidacji i stanu (np. unikalny email).
- **[SCREEN5(Add participant AJAX)]** — Krótki GIF pokazujący dodawanie uczestnika przez AJAX (formularz wysyła request, lista uczestników aktualizuje się bez przeładowania strony).
- **[SCREEN6(Sidekiq job enqueue)]** — Widok/terminal pokazujący enqueue background job (opcjonalne).
- **[SCREEN7(ERD)]** — Diagram ERD pokazujący relacje `Place -> Course -> Participant`.

> Nazwy plików sugerowane: `01_homepage.png`, `02_places_list.png`, `03_place_show_courses.png`, `04_course_show_participants.png`, `05_add_participant.gif`, `06_sidekiq.png`, `07_erd.png`.

---

## Stack technologiczny

- Ruby 3.4.5
- Rails 8.0.2.1
- PostgreSQL
- JavaScript (Vanilla / Stimulus)
- Tailwind CSS
- RSpec (testy)
- Sidekiq (background jobs)
- Heroku (deploy)

---

## Szybkie uruchomienie lokalnie

Kroki do skopiowania i wklejenia w terminalu:

```bash
git clone https://github.com/Siedlak2480/rails-courses-app
cd school
bundle install
# yarn install
rails db:create db:migrate db:seed
rails s
```

Otwórz `http://localhost:3000`.

---

## Uruchamianie testów

```bash
bundle exec rspec
```

---

## Najważniejsze endpointy (przykładowo)

- `GET /places` — lista miejsc
- `GET /places/:id` — szczegóły miejsca + listę kursów
- `GET /courses/:id` — szczegóły kursu + listę uczestników
- `POST /participants` — tworzenie uczestnika (obsługa JSON dla AJAX)

(pełna lista w `docs/routes.txt` — wygeneruj przez `rails routes > docs/routes.txt`)


---

## Dokumentacja techniczna / Notatki

- `docs/routes.txt` — wygenerowane `rails routes` dla szybkiego przeglądu endpointów.
- `docs/screenshots/` — wszystkie screeny/GIFy.
- `docs/erd.png` — diagram ERD.

---

## Co dodać dalej (TODO / roadmap)

- Autoryzacja: Devise + Pundit/CanCan
- Więcej testów integracyjnych (Cypress)
- Obsługa rake tasków / eksportów CSV
- Frontendowy polish: lepsze UX, paginacja, filtry

---

## Kontakt

GitHub: `https://github.com/Siedlak2480`/
E-mail: `pawelsiedlecki82@gmail.com`

---

