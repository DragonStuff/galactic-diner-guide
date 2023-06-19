# Galactic Diner Guide

Welcome to the Galactic Diner Guide! Whether you're a space traveler or a local alien, this guide will help you find the best dining experiences across the universe. Our mission is to provide you with the most accurate and up-to-date information about restaurants, dishes, life, the universe and everything.

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

In the project's root directory, build the Docker container with:

```bash
docker compose build
```

### Step 3: set up the database

Before starting the application, we need to create the database, run migrations and seed - and all of these will be done with this sole command:

```bash
docker compose run --rm galactic mix ecto.setup
```

### Step 4: start the application

Once the database is set, we can start the application. There are two options:

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

We can also access the database container via command line:

```bash
docker exec -it galactic_db psql -U galactic_access
```

### Step 6: testing

To run the unit tests:

```bash
docker compose run --rm galactic mix test
```

### Step 7: accessing the API

Once the application is up and running, access the API endpoint with any client or even via browser, at the GraphQL playground. 

## API and queries

Now that everything is set, our mission - should you choose to accept it - is to uncover the truth trough this magic link: 
`http://localhost:4000/graphql`

To get access to the database through GraphQL, we can use these queries and retrieve the desired details about:

1. How many customers visited the legendary "Restaurant at the End of the Universe"?
```bash
{getVisitorsPerRestaurant(restaurantName: "the-restaurant-at-the-end-of-the-universe")
{visitors}}
```
Note that `restaurantName` accepts any valid restaurant name as an argument.


2. How much money did the "Restaurant at the End of the Universe" make?
```bash
{getTotalProfitPerRestaurant(restaurantName: "the-restaurant-at-the-end-of-the-universe"){totalProfit}}
```

3. What was the most popular dish at each restaurant?
```bash
{getMostPopularFoodPerRestaurant(restaurantName: "the-restaurant-at-the-end-of-the-universe")
{mostPopularFood}}

{getMostPopularFoodPerRestaurant(restaurantName: "bean-juice-stand")
{mostPopularFood}}

{getMostPopularFoodPerRestaurant(restaurantName: "johnnys-cashew-stand")
{mostPopularFood}}

{getMostPopularFoodPerRestaurant(restaurantName: "the-ice-cream-parlor")
{mostPopularFood}}
```

4. What was the most profitable dish at each restaurant?
```bash
{getMostProfitableFoodPerRestaurant(restaurantName: "the-restaurant-at-the-end-of-the-universe") 
{mostProfitableFoodPerRestaurant}}

{getMostProfitableFoodPerRestaurant(restaurantName: "bean-juice-stand") 
{mostProfitableFoodPerRestaurant}}

{getMostProfitableFoodPerRestaurant(restaurantName: "johnnys-cashew-stand") 
{mostProfitableFoodPerRestaurant}}

{getMostProfitableFoodPerRestaurant(restaurantName: "the-ice-cream-parlor") 
{mostProfitableFoodPerRestaurant}}
```

5. Who visited each restaurant the most, and who visited the most restaurants overall?
```bash
{getMostFrequentVisitors(key: "all"){
 mostFrequentVisitors
}}
```

### May the Fork be with Us

Feel free to fork this project and adapt it to your own needs. We can customize it, add additional features, or even create a visualization of the galactic dining landscape. The universe is our playground!

## Project Development

During the development of the Galactic Diner Guide, several technical considerations were taken into account to ensure data organization, consistency, and efficient insertion into the database. The goal was to create a robust and reliable system while maintaining the relationships between tables and mitigating the risks of data loss or corruption during the massive insertion process.

To achieve these objectives, the following strategies were implemented:

### Table structure and relations

Four related tables were created to organize the data and facilitate queries. These tables included information about restaurants, customers, dishes, and transactions. By defining clear table structures and establishing appropriate relationships between them, the data can be efficiently stored and retrieved.

### Manual ID tracking system

To ensure the consistency and integrity of the data during massive insertion, a manual ID tracking system was implemented. This system involved carefully selecting which functionalities to maintain from Ecto (the database wrapper in Elixir) and manually managing the relationships between the tables.

Rather than inserting each row individually into the database, which could potentially lead to breaks or data loss, the ID tracking system ensured that the relationships between entities were maintained correctly. 

And why has it to be manually defined? When we're dealing with massive data ingestion, some facilities from Ecto (such as the automatic generated fields like timestamps and "belongs_to" kind of relations) are not available; so we choose to mime them manually.

### Ecto for data manipulation

While the ID tracking system handled the data insertion process, Ecto was mainly utilized for other data manipulation tasks with its convenient interface for querying and retrieving.

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

    Also, using tools like Terraform or AWS CloudFormation would simplify infrastructure provisioning.

By implementing these changes, we can achieve a more scalable, reliable, and maintainable Galactic Diner Guide system.
