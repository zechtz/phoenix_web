# start hound for integration tests 
Application.ensure_all_started(:hound)

ExUnit.start

Mix.Task.run "ecto.create", ~w(-r PheonixCommerce.Repo --quiet)
Mix.Task.run "ecto.migrate", ~w(-r PheonixCommerce.Repo --quiet)
Ecto.Adapters.SQL.begin_test_transaction(PheonixCommerce.Repo)

