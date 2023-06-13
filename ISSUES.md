# What causes these issues? (questions)

## 1
The below happens when `SaveAllData.save_restaurant_customers()` is run.
```
** (exit) exited in: Task.await(%Task{mfa: {:erlang, :apply, 2}, owner: #PID<0.492.0>, pid: #PID<0.546.0>, ref: #Reference<0.219173765.2591358977.211151>}, 360000)
    ** (EXIT) time out
    (elixir 1.14.0) lib/task.ex:830: Task.await/2
    (galactic_diner_guide 0.1.0) lib/galactic_diner_guide/parsers/save_all_data.ex:30: GalacticDinerGuide.Parsers.SaveAllData.call/1
    iex:1: (file)
```

It seems that the queries start timing out after some time due to the CPU being at 100%.

It's basically impossible to insert this data, even using Ecto.Multi at the moment, be aware this GitHub Codespaces machine has 8GB RAM and 2CPUs. I have prepared the following patch which turns it from a memory issue to a timeout issue:

Before:
```
    order_data
    |> Stream.chunk_every(@records_per_chunk)
    |> Task.async_stream(
      fn chunk ->
        Repo.insert_all(RestaurantCustomer, chunk)
      end,
      max_concurrency: 1
    )
    |> Stream.run()
```

After:
```
    Ecto.Multi.new()
    |> Ecto.Multi.run(:delete_all, fn _, _ ->
    Repo.delete_all(RestaurantCustomer)
    {:ok, []}
    end)
    |> Ecto.Multi.run(:insert_all, fn _, _ ->
    order_data
    |> Stream.chunk_every(@records_per_chunk)
    |> Enum.map(fn chunk ->
        Repo.insert_all(RestaurantCustomer, chunk)
        {:ok, ""}
    end)
    |> Enum.into([])
    end)
    |> Repo.transaction()
```

## 2

The below is caused by running `SaveAllData.save_restaurant_customers()` multiple times.

> SaveAllData.save_restaurant_customers()

```
[notice] SIGTERM received - shutting down

** (RuntimeError) could not lookup Ecto repo GalacticDinerGuide.Repo because it was not started or it does not exist
    (ecto 3.10.1) lib/ecto/repo/registry.ex:22: Ecto.Repo.Registry.lookup/1
    (ecto 3.10.1) lib/ecto/repo/supervisor.ex:160: Ecto.Repo.Supervisor.tuplet/2
    (galactic_diner_guide 0.1.0) lib/galactic_diner_guide/repo.ex:2: GalacticDinerGuide.Repo.all/2
    (galactic_diner_guide 0.1.0) lib/galactic_diner_guide/parsers/save_all_data.ex:98: GalacticDinerGuide.Parsers.SaveAllData.save_restaurant_customers/0
    iex:5: (file)
```

# 3
> SaveAllData.save_items(food_names, food_costs)

```
** (UndefinedFunctionError) function GalacticDinerGuide.Parsers.SaveAllData.save_items/2 is undefined or private. Did you mean:

      * save_customers/1

    (galactic_diner_guide 0.1.0) GalacticDinerGuide.Parsers.SaveAllData.save_items(["grains", "pasta", "cookies", "sugar", "ice cream", "vegetables", "spices", "salad", "oil", "soup", "candy", "chicken", "spices", "cereal", "ice cream", "candy", "cookies", "pasta", "sugar", "cereal", "candy", "grains", "cheese", "nuts", "fish", "cheese", "tea", "sugar", "chips", "beans", "vegetables", "eggs", "pasta", "beans", "nuts", "water", "eggs", "meat", "soup", "tea", "spices", "water", "chocolate", "chicken", "corn", "meat", "beans", "coffee", "cashews", "chicken", ...], ["1.0", "1.0", "4.0", "1.0", "7.0", "7.5", "5.0", "8.0", "5.0", "4.0", "6.5", "6.5", "2.5", "5.5", "8.0", "3.0", "7.0", "6.0", "4.0", "3.0", "3.5", "2.5", "3.0", "4.0", "3.5", "6.0", "6.0", "2.0", "4.0", "5.5", "6.5", "1.0", "1.5", "8.5", "3.5", "4.0", "4.0", "5.0", "6.0", "5.0", "2.5", "5.0", "4.0", "8.5", "9.0", "3.0", "8.5", "3.5", "4.5", "5.0", ...])
    iex:6: (file)
```