defmodule PortifolioWeb.HomeLive do
  use PortifolioWeb, :live_view

  alias Portifolio.Projects

  def mount(_params, _session, socket) do
    {:ok, assign(socket, projects: Projects.list_projects())}
  end
end
