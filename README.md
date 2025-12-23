# Airflow Development Environment

A local Apache Airflow development environment powered by [devenv](https://devenv.sh/) and Nix.

## Overview

This project provides a reproducible development environment for Apache Airflow 3.1.5 using devenv. It automatically sets up Python 3.13, installs dependencies, and manages multiple Airflow processes.

## Prerequisites

- [Nix](https://nixos.org/download.html) package manager
- [devenv](https://devenv.sh/getting-started/) installed

## Quick Start

1. **Clone the repository** and navigate to the project directory:
   ```bash
   cd airflow-env
   ```

2. **Enter the development environment**:
   ```bash
   devenv shell
   ```

3. **Initialize Airflow** (first time only):
   ```bash
   devenv tasks run airflow:install
   ```

4. **Start all Airflow services**:
   ```bash
   devenv up
   ```

5. **Access the Airflow UI**:
   Open [http://localhost:8080](http://localhost:8080) in your browser.

## Default Credentials

- **Username**: `admin`
- **Password**: Check `airflow/simple_auth_manager_passwords.json.generated`

## Project Structure

```
airflow-env/
├── devenv.nix          # Devenv configuration (processes, tasks, packages)
├── devenv.yaml         # Devenv inputs and settings
├── requirements.txt    # Python dependencies (Apache Airflow)
├── airflow/
│   ├── airflow.cfg     # Airflow configuration
│   ├── dags/           # Place your DAG files here
│   └── logs/           # Airflow logs
└── README.md
```

## Services

The development environment runs the following Airflow services via `mprocs`:

| Service        | Description                              |
|----------------|------------------------------------------|
| `scheduler`    | Airflow Scheduler                        |
| `webserver`    | Airflow API Server (port 8080)           |
| `dagprocessor` | Airflow DAG Processor                    |
| `triggerer`    | Airflow Triggerer                        |

## Available Tasks

| Task                  | Command                              | Description                          |
|-----------------------|--------------------------------------|--------------------------------------|
| `airflow:install`     | `devenv tasks run airflow:install`   | Install dependencies and migrate DB |
| `airflow:uninstall`   | `devenv tasks run airflow:uninstall` | Uninstall packages and remove data  |

## Configuration

### Environment Variables

| Variable             | Value                                              |
|----------------------|----------------------------------------------------|
| `AIRFLOW_HOME`       | `/home/vickyf/Documents/Code/airflow-env/airflow`  |
| `PYTHONUNBUFFERED`   | `1`                                                |

### Airflow Settings

Key configuration in `airflow/airflow.cfg`:

- **Executor**: `LocalExecutor`
- **Auth Manager**: `SimpleAuthManager`
- **Default Timezone**: `UTC`
- **Parallelism**: `32`

## Adding DAGs

Place your DAG Python files in the `airflow/dags/` directory. They will be automatically detected by the DAG processor.

## Useful Commands

```bash
# Enter the dev environment
devenv shell

# Start all services
devenv up

# Run a specific Airflow command
airflow dags list
airflow tasks list <dag_id>

# Trigger a DAG run
airflow dags trigger <dag_id>
```

## License

This project is for local development purposes.
