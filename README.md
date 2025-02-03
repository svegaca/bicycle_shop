# Bicycle Shop

Bicycle Shop is a Rails-based application for managing products with customizable options and combination rules. It provides an admin dashboard using ActiveAdmin to manage products, option types, option values, and combination rules.

## Technologies Used

- **Ruby** 3.4.1
- **Rails** 8.0.1
- **PostgreSQL** as the database
- **ActiveAdmin** for the admin dashboard
- **FactoryBot & RSpec** for testing

## Setup Instructions

To set up the project locally, follow these steps:

### Prerequisites

Ensure you have installed:
- Ruby 3.4.1
- Rails 8.0.1
- PostgreSQL
- Bundler (`gem install bundler` if not installed)

### Installation

1. **Clone the repository**
   ```sh
   git clone git@github.com:svegaca/bicycle_shop.git
   cd bicycle_shop
   ```

2. **Install dependencies**
   ```sh
   bundle install
   ```

3. **Set up the database**
   ```sh
   bin/rails db:create
   bin/rails db:migrate
   bin/rails db:seed  # Loads sample data
   ```

4. **Start the Rails server**
   ```sh
   bin/rails server
   ```
   The application will be available at `http://localhost:3000`

### Running Tests

To run the test suite:
```sh
bin/rspec
```

## Seeding the Database

The application includes a seed file (`db/seeds.rb`) that populates the database with example products, option types, option values, and combination rules. After setting up the database, run:
```sh
bin/rails db:seed
```
This will create sample data for testing and development purposes.

## Contribution Guidelines

If you'd like to contribute:
1. Fork the repository.
2. Create a new branch (`git checkout -b feature-branch`).
3. Make your changes and commit (`git commit -m 'Add new feature'`).
4. Push to your branch (`git push origin feature-branch`).
5. Create a pull request.

## License

This project is licensed under the MIT License.
