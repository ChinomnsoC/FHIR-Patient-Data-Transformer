# FHIR Patient Data Pipeline

Transform healthcare data with confidence. Convert CSV patient records to FHIR R4 standard formats (JSON/YAML) with built-in validation and complete test coverage.

🔧 **Built with:** Python 3.12.9, FHIR.resources, Docker, Poetry  
📋 **Standards:** FHIR R4 compliant  
✅ **Testing:** Full pytest suite with data integrity verification  
🚀 **Deployment:** Dockerized for reproducible environments  

## Quick Start

### Prerequisites

- Python 3.12.9
- Poetry
- Docker (optional)

### Installation

1. Clone the repository:

```bash
git clone <repository-url>
cd fhir-patient-pipeline
```

2. Install dependencies:

```bash
poetry install
```

3. Run the pipeline:

```bash
poetry run python -m src.main -i data/input/sample_patients.csv -o data/output -f both
```

### Docker Usage

Build and run with Docker:
```bash
docker-compose up --build
```

### Development

Run tests:
```bash
./scripts/test.sh
```

Format code:
```bash
poetry run black src/ tests/
poetry run isort src/ tests/
```

## Project Structure

```
fhir-patient-pipeline/
├── src/
│   ├── transformers/   # CSV to FHIR transformations
│   ├── validators/      # FHIR validation logic
│   └── utils/          # Helper utilities
├── tests/
│   ├── unit/           # Unit tests
│   ├── integration/    # Integration tests
│   └── fixtures/       # Test data
├── data/
│   ├── input/          # Input CSV files
│   └── output/         # Generated FHIR files
├── docker/             # Docker configuration
└── scripts/            # Helper scripts
```

## License

MIT
