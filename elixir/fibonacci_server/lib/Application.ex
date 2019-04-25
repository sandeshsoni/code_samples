defmodule Fibonacci.Application do
  use Application

  def start(_type, _args) do

    import Supervisor.Spec

    children = [
      # worker(Fibonacci.Server, []),
      %{
        id: Fib,
        # start: {Fibonacci.Server, :start_link, []}
        start: {Fibonacci, :new_calculator, []}
      },
      Plug.Cowboy.child_spec(
        scheme: :http,
        # plug: Fibonacci.WebPlug,
        plug: Fibonacci.Router,
        options: [port: 8080]
      )
    ]

    options = [ strategy: :one_for_one, name: Fibonacci.Supervisor]

    Supervisor.start_link(children, options)
  end

  # commands from terminal should work.
  # GenServer.call(Fib, :get_history)
  # GenServer.call(Fib, {:get_fibonacci, 21})

end
