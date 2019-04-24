defmodule FibonacciApp do
  use Application

  def start(_type, _args) do
    children = [
      %{
        id: Fibonacci,
        start: {Fibonacci, :new_calculator, []}
      },
      Plug.Cowboy.child_spec(
        scheme: :http,
        # plug: Fibonacci.WebPlug,
        plug: Fibonacci.Router,
        options: [port: 8080]
      )
    ]

    Supervisor.start_link(children, strategy: :one_for_one)
  end

end
