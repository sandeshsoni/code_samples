defmodule Fibonacci.Router do
  use Plug.Router

  plug :match
  plug :dispatch
  plug Plug.Parsers, parsers: [:json],
    pass: ["text/*"],
    json_decoder: Jason

  get("/hello") do
    send_resp(conn, 200, "world")
  end

  get("/fib") do
    body = Jason.encode!(%{ a: "b" })

    conn
    |> put_resp_content_type("text/json")
    |> send_resp(200,body)
  end

end
