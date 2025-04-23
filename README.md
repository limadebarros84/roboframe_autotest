# Robot Framework Tests

This project contains automated tests written in Robot Framework for processing various requests related to real estate financing and management. The tests are organized into separate files for clarity and maintainability.

## Project Structure

```
robot-framework-tests
├── .github
│   └── workflows
│       └── daily-test-execution.yml  # GitHub Actions workflow for daily test execution
├── tests
│   ├── Aanvraag_bijzonder_beheer_via_tussen_persoon.robot  # Test case for forced sale via intermediary
│   └── Aanvraag_nieuwbouw_via_aanvraagstraat.robot  # Test case for financing request for new construction
├── resources
│   └── keywords
│       ├── Global.robot  # Global keywords for reuse across tests
│       └── Aanvraag_straat_keywords.resource  # Specific keywords for street application process
├── requirements.txt  # Dependencies for the Robot Framework tests
└── README.md  # Documentation for the project
```

## Setup Instructions

1. **Clone the Repository**
   ```bash
   git clone <repository-url>
   cd robot-framework-tests
   ```

2. **Install Dependencies**
   Ensure you have Python installed, then install the required packages:
   ```bash
   pip install -r requirements.txt
   ```

3. **Running Tests Locally**
   You can run the tests locally using the following command:
   ```bash
   robot tests/
   ```

## GitHub Actions

The project includes a GitHub Actions workflow located in `.github/workflows/daily-test-execution.yml` that automatically runs the tests daily. This ensures that the tests are continuously validated against the latest code changes.

## Contribution

Feel free to contribute to this project by submitting issues or pull requests. Ensure that any new tests are added to the appropriate test files and that they follow the existing structure and conventions.

## License

This project is licensed under the MIT License. See the LICENSE file for more details.
