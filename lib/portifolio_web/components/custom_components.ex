defmodule PortifolioWeb.CustomComponents do
  use Phoenix.Component
  #use Gettext, backend: PortifolioWeb.Gettext

  alias Phoenix.LiveView.JS

  import PortifolioWeb.CoreComponents

  @doc """
  Renderiza o header para mobile e desktop
  """
  def header(assigns) do
    ~H"""
    <header class="sticky top-0 z-50">
      <nav class="flex items-center justify-between md:grid md:grid-cols-3 p-4 max-w-7xl mx-auto">
        <!-- 1. Fatia da Esquerda (Logo/Nome) -->
        <div class="font-bold text-white-800 md:justify-self-start">
          Ricardo Ferreira
        </div>

        <!-- 2. Fatia do Centro (Menu) -->
        <ul class="hidden gap-8 font-medium border border-gray-200 rounded-full py-2 px-4 md:justify-self-center md:flex">
          <li><a href="#about" class="hover:text-blue-600 transition">Sobre</a></li>
          <li><a href="#projects" class="hover:text-blue-600 transition">Projetos</a></li>
          <li><a href="#reserch" class="hover:text-blue-600 transition">Pesquisa</a></li>
          <li><a href="#tecnologies" class="hover:text-blue-600 transition">Tecnologias</a></li>
          <li><a href="#certificates" class="hover:text-blue-600 transition">Certificados</a></li>
          <li><a href="#contact" class="hover:text-blue-600 transition">Contato</a></li>
        </ul>

        <!-- 3. Fatia da Direita (Dark Mode + Sanduíche) -->
        <div class="flex items-center gap-4 md:justify-self-end">
          <PortifolioWeb.Layouts.theme_toggle />

          <button
            phx-click={JS.toggle(to: "#mobile-menu")}
            class="md:hidden block text-gray-600 focus:outline-none"
            aria-label="Abrir menu"
          >
            <.icon name="hero-bars-3" class="w-8 h-8" />
          </button>
        </div>
      </nav>

      <!-- Menu Mobile -->
      <div
        id="mobile-menu"
        class="hidden absolute top-full left-0 w-full md:hidden bg-black border-gray-200 shadow-lg"
      >
        <ul class="flex flex-col p-4 gap-8 text-center font-medium text-white-700">
          <li><a href="#about" class="block hover:text-blue-600">Sobre</a></li>
          <li><a href="#projects" class="block hover:text-blue-600">Projetos</a></li>
          <li><a href="#reserch" class="block hover:text-blue-600">Pesquisa</a></li>
          <li><a href="#tecnologies" class="block hover:text-blue-600">Tecnologias</a></li>
          <li><a href="#certificates" class="block hover:text-blue-600">Certificados</a></li>
          <li><a href="#contact" class="block hover:text-blue-600">Contato</a></li>
        </ul>
      </div>
    </header>
    """
  end

  @doc """
  Renderiza a seção "Sobre"
  """
  def about(assigns) do
    ~H"""
    <section class="grid grid-cols-1 gap-4 p-4 mt-8 text-xl items-center justify-center md:grid-cols-2 md:min-h-[80vh] md:m-8" id="about">
      <div class="flex items-center justify-center mx-auto w-48 h-48 md:w-96 md:h-96">
        <img
          src="https://github.com/ricardoof.png"
          alt="Foto de Ricardo Ferreira"
          class="rounded-full w-full h-full object-cover"
        />
      </div>

      <div class="flex flex-col gap-4 text-center md:text-left">
        <h1>Olá, meu nome é Ricardo Ferreira</h1>

        <p>Sou estudante de Ciência da Computação na UFV (8º período) e Desenvolvedor Full Stack, apaixonado por criar softwares eficientes e escaláveis.
        Atualmente, meu grande foco é o ecossistema funcional, utilizando a linguagem de programação funcional <strong>Elixir</strong> e o framework <strong>Phoenix</strong> para escalabilidade e concorrência.</p>
      </div>
    </section>
    """
  end

  @doc """
  Renderiza um projeto.
  """
  def projects(assigns) do
    ~H"""
    <div
      class="flex flex-col gap-4 items-center md:mx-8"
      id="projects"
    >
      <h2 class="text-4xl">
        Projetos
      </h2>

      <div class="grid grid-cols-1 gap-8 p-4 md:grid-cols-3 md:m-8">
        <div
          class={["h-full", index >= 3 && "hidden more-projects"]}
          :for={{project, index} <- Enum.with_index(@projects)}
        >
          <div class="flex flex-col h-full gap-4 p-4 rounded-lg shadow-lg dark:border">
            <img
              src={project.image}
              alt={project.title}
              class="rounded-lg"
            />

            <h3 class="text-2xl"><%= project.title %></h3>

            <p class="text-sm flex-grow"><%= project.description %></p>

            <div class="flex flex-row gap-4 m-2 mt-auto">
              <.link href={project.link_deploy} target="_blank">
                <.icon name="hero-computer-desktop" class="w-8 h-8" />
              </.link>

              <.link href={project.link_github} target="_blank">
                <img src="https://cdn.jsdelivr.net/gh/devicons/devicon@latest/icons/github/github-original.svg" class="w-8 h-8"/>
              </.link>
            </div>
          </div>
        </div>
      </div>

      <%= if length(@projects) > 3 do %>
        <div class="mt-4">
          <button
            id="show-more-btn"
            phx-click={JS.remove_class("hidden", to: ".more-projects") |> JS.hide()}
            class="btn btn-outline btn-wide rounded-full"
          >
            Mostrar mais
          </button>
        </div>
      <% end %>
    </div>
    """
  end
end
