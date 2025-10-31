#!/bin/bash

# FHIR Patient Data Pipeline - Project Setup Script
# This script sets up the complete development environment using Poetry

set -e  # Exit on error

echo "========================================="
echo "FHIR Patient Data Pipeline Setup"
echo "Python 3.12.9 + Poetry"
echo "========================================="
echo ""

# Project name
# PROJECT_NAME="fhir-patient-pipeline"

# # Check if poetry is installed
# if ! command -v poetry &> /dev/null; then
#     echo "Poetry not found. Installing Poetry..."
#     curl -sSL https://install.python-poetry.org | python3 -
#     export PATH="$HOME/.local/bin:$PATH"
# else
#     echo "✓ Poetry is already installed"
# fi

# # Create project directory
# echo ""
# echo "Creating project directory: $PROJECT_NAME"
# mkdir -p $PROJECT_NAME
# cd $PROJECT_NAME

# # Initialize git repository
# echo "Initializing git repository..."
# git init

# Create project structure
echo "Creating project structure..."
mkdir -p src/{transformers,validators,utils}
mkdir -p tests/{unit,integration,fixtures}
mkdir -p data/{input,output}
mkdir -p scripts
mkdir -p docker

# Create initial Python files to establish package structure
touch src/__init__.py
touch src/transformers/__init__.py
touch src/validators/__init__.py
touch src/utils/__init__.py
touch tests/__init__.py

# Initialize Poetry project with Python 3.12.9
# echo ""
# echo "Initializing Poetry project with Python 3.12.9..."
# poetry init \
#     --name "$PROJECT_NAME" \
#     --description "A Python-based data transformation pipeline that converts patient records from CSV to FHIR-compliant JSON and YAML formats" \
#     --author "Your Name <your.email@example.com>" \
#     --python "^3.12" \
#     --no-interaction

# # Configure Poetry to create virtual environment in project directory
# poetry config virtualenvs.in-project true

# # Add production dependencies
# echo ""
# echo "Adding production dependencies..."
# poetry add fhir.resources@^14.0.0
# poetry add pandas@^2.2.0
# poetry add pyyaml@^6.0
# poetry add pydantic@^2.5.0
# poetry add click@^8.1.0  # For CLI interface
# poetry add python-dotenv@^1.0.0  # For environment variables
# poetry add orjson@^3.9.0  # Fast JSON serialization

# # Add development dependencies
# echo ""
# echo "Adding development dependencies..."
# poetry add --group dev pytest@^8.0.0
# poetry add --group dev pytest-cov@^4.1.0  # Coverage reporting
# poetry add --group dev pytest-mock@^3.12.0  # Mocking support
# poetry add --group dev black@^24.0.0  # Code formatting
# poetry add --group dev isort@^5.13.0  # Import sorting
# poetry add --group dev flake8@^7.0.0  # Linting
# poetry add --group dev mypy@^1.8.0  # Type checking
# poetry add --group dev pre-commit@^3.6.0  # Git hooks

# # Create .gitignore
# echo "Creating .gitignore..."
# cat > .gitignore << 'EOF'
# # Python
# __pycache__/
# *.py[cod]
# *$py.class
# *.so
# .Python
# env/
# venv/
# ENV/
# .venv
# *.egg-info/
# dist/
# build/

# # Poetry
# poetry.lock
# .venv/

# # IDE
# .vscode/
# .idea/
# *.swp
# *.swo
# *~
# .DS_Store

# # Project specific
# data/output/*
# !data/output/.gitkeep
# *.log
# .coverage
# htmlcov/
# .pytest_cache/
# .mypy_cache/

# # Docker
# docker-compose.override.yml

# # Environment
# .env
# .env.local
# EOF

# # Create .dockerignore
# echo "Creating .dockerignore..."
# cat > .dockerignore << 'EOF'
# __pycache__
# *.pyc
# *.pyo
# *.pyd
# .Python
# env/
# venv/
# .venv/
# pip-log.txt
# pip-delete-this-directory.txt
# .tox/
# .coverage
# .coverage.*
# .cache
# nosetests.xml
# coverage.xml
# *.cover
# *.log
# .git
# .gitignore
# .mypy_cache
# .pytest_cache
# .hypothesis
# .idea
# .vscode
# *.swp
# *.swo
# *~
# .DS_Store
# data/output/*
# tests/
# README.md
# poetry.lock
# pyproject.toml
# EOF

# # Create pyproject.toml additions for tool configurations
# echo ""
# echo "Configuring development tools in pyproject.toml..."
# cat >> pyproject.toml << 'EOF'

# [tool.black]
# line-length = 100
# target-version = ['py312']
# include = '\.pyi?$'

# [tool.isort]
# profile = "black"
# line_length = 100
# multi_line_output = 3
# include_trailing_comma = true
# force_grid_wrap = 0
# use_parentheses = true

# [tool.pytest.ini_options]
# minversion = "8.0"
# testpaths = ["tests"]
# python_files = "test_*.py"
# python_classes = "Test*"
# python_functions = "test_*"
# addopts = """
#     -v
#     --tb=short
#     --strict-markers
#     --cov=src
#     --cov-report=term-missing
#     --cov-report=html
# """

# [tool.mypy]
# python_version = "3.12"
# warn_return_any = true
# warn_unused_configs = true
# disallow_untyped_defs = true
# disallow_any_unimported = false
# no_implicit_optional = true
# warn_redundant_casts = true
# warn_unused_ignores = true
# warn_no_return = true
# warn_unreachable = true
# strict_equality = true

# [tool.coverage.run]
# source = ["src"]
# omit = ["*/tests/*", "*/__init__.py"]

# [tool.coverage.report]
# exclude_lines = [
#     "pragma: no cover",
#     "def __repr__",
#     "if self.debug:",
#     "if __name__ == .__main__.:",
#     "raise NotImplementedError",
#     "pass",
#     "except ImportError:",
# ]
# EOF

# # Create sample CSV data
# echo "Creating sample patient data..."
# cat > data/input/sample_patients.csv << 'EOF'
# id,first_name,last_name,gender,birth_date,phone,email,address_line,city,state,postal_code,country
# 001,John,Doe,male,1980-01-15,555-0123,john.doe@email.com,123 Main St,Boston,MA,02101,USA
# 002,Jane,Smith,female,1992-06-22,555-0124,jane.smith@email.com,456 Oak Ave,Cambridge,MA,02139,USA
# 003,Robert,Johnson,male,1975-11-30,555-0125,r.johnson@email.com,789 Pine Rd,Somerville,MA,02144,USA
# # EOF

# # Create .gitkeep files for empty directories
# touch data/output/.gitkeep
# touch tests/fixtures/.gitkeep

# # Create main.py entry point
# echo "Creating main application entry point..."
# cat > src/main.py << 'EOF'
# #!/usr/bin/env python3
# """
# FHIR Patient Data Pipeline
# Main entry point for the transformation pipeline
# """

# import click
# import logging
# from pathlib import Path

# logging.basicConfig(
#     level=logging.INFO,
#     format='%(asctime)s - %(name)s - %(levelname)s - %(message)s'
# )
# logger = logging.getLogger(__name__)


# @click.command()
# @click.option(
#     '--input', '-i',
#     type=click.Path(exists=True),
#     required=True,
#     help='Path to input CSV file'
# )
# @click.option(
#     '--output', '-o',
#     type=click.Path(),
#     required=True,
#     help='Path to output directory'
# )
# @click.option(
#     '--format', '-f',
#     type=click.Choice(['json', 'yaml', 'both']),
#     default='both',
#     help='Output format (default: both)'
# )
# @click.option(
#     '--validate/--no-validate',
#     default=True,
#     help='Validate FHIR compliance (default: True)'
# )
# def main(input, output, format, validate):
#     """Convert patient data from CSV to FHIR-compliant formats."""
#     logger.info(f"Starting FHIR Patient Data Pipeline")
#     logger.info(f"Input: {input}")
#     logger.info(f"Output: {output}")
#     logger.info(f"Format: {format}")
#     logger.info(f"Validation: {validate}")
    
#     # TODO: Implement transformation logic
#     click.echo("Pipeline execution complete!")


# if __name__ == "__main__":
#     main()
# EOF

# # Create Dockerfile
# echo "Creating Dockerfile..."
# cat > Dockerfile << 'EOF'
# FROM python:3.12.9-slim

# # Set working directory
# WORKDIR /app

# # Set environment variables
# ENV PYTHONDONTWRITEBYTECODE=1 \
#     PYTHONUNBUFFERED=1 \
#     POETRY_VERSION=1.7.1 \
#     POETRY_HOME="/opt/poetry" \
#     POETRY_VIRTUALENVS_CREATE=false \
#     POETRY_NO_INTERACTION=1

# # Install system dependencies
# RUN apt-get update && apt-get install -y \
#     curl \
#     gcc \
#     && rm -rf /var/lib/apt/lists/*

# # Install Poetry
# RUN curl -sSL https://install.python-poetry.org | python3 - && \
#     ln -s /opt/poetry/bin/poetry /usr/local/bin/poetry

# # Copy dependency files
# COPY pyproject.toml poetry.lock* ./

# # Install dependencies
# RUN poetry install --no-root --only main

# # Copy application code
# COPY src/ ./src/
# COPY data/ ./data/

# # Create output directory
# RUN mkdir -p /app/data/output

# # Set entrypoint
# ENTRYPOINT ["python", "-m", "src.main"]
# EOF

# # Create docker-compose.yml
# echo "Creating docker-compose.yml..."
# cat > docker-compose.yml << 'EOF'
# version: '3.8'

# services:
#   fhir-pipeline:
#     build: .
#     container_name: fhir-patient-pipeline
#     volumes:
#       - ./data/input:/app/data/input:ro
#       - ./data/output:/app/data/output
#       - ./src:/app/src:ro
#     environment:
#       - PYTHONPATH=/app
#       - LOG_LEVEL=INFO
#     command: ["-i", "/app/data/input/sample_patients.csv", "-o", "/app/data/output", "-f", "both"]
# EOF

# # Create setup.sh helper script
# echo "Creating setup.sh helper script..."
# cat > scripts/setup.sh << 'EOF'
# #!/bin/bash
# # Setup development environment

# echo "Installing Poetry dependencies..."
# poetry install

# echo "Installing pre-commit hooks..."
# poetry run pre-commit install

# echo "Running initial tests..."
# poetry run pytest tests/ -v

# echo "Setup complete!"
# EOF
# chmod +x scripts/setup.sh

# # Create run.sh helper script
# echo "Creating run.sh helper script..."
# cat > scripts/run.sh << 'EOF'
# #!/bin/bash
# # Run the FHIR pipeline

# poetry run python -m src.main "$@"
# EOF
# chmod +x scripts/run.sh

# # Create test.sh helper script
# echo "Creating test.sh helper script..."
# cat > scripts/test.sh << 'EOF'
# #!/bin/bash
# # Run all tests with coverage

# echo "Running tests with coverage..."
# poetry run pytest tests/ -v --cov=src --cov-report=term-missing --cov-report=html

# echo "Running type checking..."
# poetry run mypy src/

# echo "Running linting..."
# poetry run flake8 src/ tests/

# echo "Checking code formatting..."
# poetry run black --check src/ tests/
# poetry run isort --check-only src/ tests/
# EOF
# chmod +x scripts/test.sh

# # Create README.md
# echo "Creating README.md..."
# cat > README.md << 'EOF'
# # FHIR Patient Data Pipeline

# Transform healthcare data with confidence. Convert CSV patient records to FHIR R4 standard formats (JSON/YAML) with built-in validation and complete test coverage.

# 🔧 **Built with:** Python 3.12.9, FHIR.resources, Docker, Poetry  
# 📋 **Standards:** FHIR R4 compliant  
# ✅ **Testing:** Full pytest suite with data integrity verification  
# 🚀 **Deployment:** Dockerized for reproducible environments  

# ## Quick Start

# ### Prerequisites
# - Python 3.12.9
# - Poetry
# - Docker (optional)

# ### Installation

# 1. Clone the repository:
# ```bash
# git clone <repository-url>
# cd fhir-patient-pipeline
# ```

# 2. Install dependencies:
# ```bash
# poetry install
# ```

# 3. Run the pipeline:
# ```bash
# poetry run python -m src.main -i data/input/sample_patients.csv -o data/output -f both
# ```

# ### Docker Usage

# Build and run with Docker:
# ```bash
# docker-compose up --build
# ```

# ### Development

# Run tests:
# ```bash
# ./scripts/test.sh
# ```

# Format code:
# ```bash
# poetry run black src/ tests/
# poetry run isort src/ tests/
# ```

# ## Project Structure

# ```
# fhir-patient-pipeline/
# ├── src/
# │   ├── transformers/   # CSV to FHIR transformations
# │   ├── validators/      # FHIR validation logic
# │   └── utils/          # Helper utilities
# ├── tests/
# │   ├── unit/           # Unit tests
# │   ├── integration/    # Integration tests
# │   └── fixtures/       # Test data
# ├── data/
# │   ├── input/          # Input CSV files
# │   └── output/         # Generated FHIR files
# ├── docker/             # Docker configuration
# └── scripts/            # Helper scripts
# ```

# ## License

# MIT
# EOF

# # Install dependencies
# echo ""
# echo "Installing dependencies with Poetry..."
# poetry install

# # Final message
# echo ""
# echo "========================================="
# echo "✅ Project setup complete!"
# echo "========================================="
# echo ""
# echo "Project created at: $(pwd)"
# echo ""
# echo "Next steps:"
# echo "1. Activate virtual environment: poetry shell"
# echo "2. Run tests: ./scripts/test.sh"
# echo "3. Start coding in src/"
# echo "4. Run the pipeline: ./scripts/run.sh -i data/input/sample_patients.csv -o data/output"
# echo ""
# echo "Docker commands:"
# echo "  - Build: docker-compose build"
# echo "  - Run: docker-compose up"
# echo ""
# echo "Happy coding! 🚀"