defmodule PortifolioWeb.PageController do
  use PortifolioWeb, :controller

  def home(conn, _params) do
    render(conn, :home)
  end
end
