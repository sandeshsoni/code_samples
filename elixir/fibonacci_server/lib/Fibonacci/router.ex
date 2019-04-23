defmodule Fibonacci.Router do
  use Plug.Router

  plug :match
  plug :dispatch

  get("/hello") do
    send_resp(conn, 200, "world")
  end

  get("/fibonacci") do
    send_resp(conn, 200, "world")
  end

end
