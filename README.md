# Galactic Diner Guide

Welcome to the Galactic Diner Guide! Whether you're a space traveler or a local alien, this guide will help you find the best dining experiences across the universe. Our mission is to provide you with the most accurate and up-to-date information about restaurants, customers, dishes, and more.

## Installation

Follow the steps below to set up the project on your machine.

### Prerequisites

Make sure you have the following prerequisites installed on your system:

- Docker Compose
- Postgres

### Step 1: clone the repository

Clone the repository to your local machine:

```bash
git clone git@github.com:debora-be/galactic-diner-guide.git
cd galactic-diner-guide
```

### Step 2: build the Docker container

In the project's root directory, build the Docker container using the following command:

```bash
docker compose build
```

### Step 3: set up the database

Before starting the application, we need to create the database and run migrations and seeds. Run the following command to do all of these at one glance:

```bash
docker compose run --rm galactic mix ecto.setup
```

### Step 4: start the application

Once the database is set up, you can start the application using Docker Compose. There are two options:

- Start the application and view the logs in the terminal:

  ```bash
  docker compose up
  ```

- Start the application in detached mode:

  ```bash
  docker compose up -d
  ```

### Step 5: accessing the container

If you need to access the container's shell, use the following command:

```bash
docker compose run --rm galactic ash
```

### Step 6: testing

To run the unit tests for the project:

```bash
docker compose run --rm galactic mix test
```

### Step 7: accessing the API

Once the application is up and running, you can access the API endpoint with any client or even via browser, at the Graphql playground. And if you are here, have succeeded to install and set up the Galactic Diner Guide - **now** you're ready to explore the universe of dining experiences!

May your taste buds be forever delighted as you embark on this gastronomic journey!

## Dataset and API

To kickstart your gastronomic adventure, we have provided you with a dataset located in `/sources/data.csv` - but don't panic! The data was inserted automatically while setting up Ecto.

Your mission, should you choose to accept it, is to uncover the truth trough this magic link: 
`http://localhost:4000/graphql`

1. How many customers visited the legendary "Restaurant at the End of the Universe"?
```json
{getVisitorsPerRestaurant(restaurantName: "the-restaurant-at-the-end-of-the-universe")
{visitors}}
```
2. How much money did the "Restaurant at the End of the Universe" make?
```json
{getTotalProfitPerRestaurant(restaurantName: "the-restaurant-at-the-end-of-the-universe"){totalProfit}}
```
3. What was the most popular dish at each restaurant?
```json
{getMostPopularFoodPerRestaurant(restaurantName: "the-restaurant-at-the-end-of-the-universe")
{mostPopularFood}}
```
4. What was the most profitable dish at each restaurant?
```json
{getMostLucrativeFoodPerRestaurant(restaurantName: "the-restaurant-at-the-end-of-the-universe")
{getMostLucrativeFoodPerRestaurant}}

{getMostLucrativeFoodPerRestaurant(restaurantName: "bean-juice-stand")
{getMostLucrativeFoodPerRestaurant}}

{getMostLucrativeFoodPerRestaurant(restaurantName: "johnnys-cashew-stand")
{getMostLucrativeFoodPerRestaurant}}

{getMostLucrativeFoodPerRestaurant(restaurantName: "the-ice-cream-parlor")
{getMostLucrativeFoodPerRestaurant}}
```
5. Who visited each restaurant the most, and who visited the most restaurants overall?
```json
{getMostVisited()
{mostVisited}}
```

### May the Fork be with You

Feel free to fork this project and adapt it to your own needs. You can customize it, add additional features, or even create a visualization of the galactic dining landscape. The universe is your playground!

## Project Development

During the development of the Galactic Diner Guide, several technical considerations were taken into account to ensure data organization, consistency, and efficient insertion into the database. The goal was to create a robust and reliable system while maintaining the relationships between tables and mitigating the risks of data loss or corruption during the massive data insertion process.

To achieve these objectives, the following strategies were implemented:

### Table structure and relations

Four related tables were created to organize the data and facilitate queries. These tables included information about restaurants, customers, dishes, and transactions. By defining clear table structures and establishing appropriate relationships between them, the data can be efficiently stored and retrieved.

### Manual ID tracking system

To ensure the consistency and integrity of the data during massive insertion, a manual ID tracking system was implemented. This system involved carefully selecting which functionalities to maintain from Ecto (the database wrapper in Elixir) and manually managing the relationships between the tables.

Rather than inserting each row individually into the database, which could potentially lead to breaks or data loss, the ID tracking system ensured that the relationships between entities were maintained correctly. 

### Ecto for data manipulation

While the ID tracking system handled the data insertion process, Ecto was still utilized for other data manipulation tasks with its convenient interface for querying and retrieving.

### Data Ingestion

To populate the database with initial data, a dataset located in `/sources/data.csv` was provided. During the Ecto setup process, this dataset was supposed to be ingested into the database, ensuring that all necessary data was available for queries and analysis - but there was an unexpected issue, and the last tables are not loading (it works well, when the patch is done); but for now, we're experiencing some instability for queries, that will be normalized within the next hours.

## Issues

We're actively working to identify and fix the problem and assure the automatized data ingestion. Additional tests are been added to ensure the application's stability and reliability with a 90% coverage. Your patience is appreciated as we work towards resolving this matter and delivering a dependable Galactic Diner Guide. Besides that, you may notice some few commented lines on the code, because of the work that's still in progress.

## Work in progress

Let's explore how we would approach building the project differently if the data was being streamed from Kafka and how we could improve the system's deployment.

1. Data Streaming from Kafka

If we were streaming data from Kafka, we would make the following adjustments:

    Integrate the application with Kafka client libraries to consume data from its topics;

    Add a step to transform the incoming data to fit our database schemas or any specific requirements;

    With real-time data processing, the application would provide immediate updates for queries and analysis.

2. Deployment improvements

To enhance the system's deployment, we could consider the following:

    Container Orchestration: instead of Docker Compose, we could use Kubernetes for better scalability and management;

    Horizontal Scaling: Kubernetes would enable running multiple instances of the application for handling increased traffic;

    CI/CD: implementing CI/CD pipelines would automate the build, test, and deployment processes;

    ALso, using tools like Terraform or AWS CloudFormation would simplify infrastructure provisioning.

By implementing these changes, we can achieve a more scalable, reliable, and maintainable Galactic Diner Guide system.
