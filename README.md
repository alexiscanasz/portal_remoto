# Portal Remoto — Fase 2

App Flutter de la Fase 2 de la ruta de crecimiento, consume la [API de Rick and Morty](https://rickandmortyapi.com/) para listar, buscar y ver el detalle de personajes.

<img src="https://github.com/user-attachments/assets/b05a9515-e36e-4a9f-9113-3c878e066b02" alt="home" width="220" /> &nbsp;
<img src="https://github.com/user-attachments/assets/ef0969ca-38a7-4529-bfbb-60f288d709bf" alt="character detail" width="220" /> &nbsp;
<img src="https://github.com/user-attachments/assets/e5b50552-4c6a-4ba4-b955-ea391b2f3de5" alt="search" width="220" />


## Funcionalidad

- Listado de personajes obtenido desde `GET /api/character`.
- Busqueda por nombre (`?name=`).
- Detalle de personaje (`GET /api/character/{id}`) con su propio estado de carga/error.
- Estados de carga, error (con reintento) y vacío (sin resultados de búsqueda).

## Demostración de funcionalidad

https://github.com/user-attachments/assets/8cdb9001-0b57-488c-a7cc-fa55ffc87857

## Arquitectura

Organización por capas dentro de `lib/features/characters/`:

- `data/` — modelos, datasource remoto (Dio) y repositorio.
- `domain/` — entidad `Character`, contrato del repositorio y use cases.
- `presentation/` — providers de **Riverpod 3** (estado de la lista, búsqueda y detalle) y las pantallas.

El manejo de errores usa un tipo `Result<T>` (`Success`/`Failure`) en `core/error/`, evitando exponer excepciones directamente a la UI.

## Cómo ejecutar

```bash
flutter pub get
flutter run
```
