defmodule PortifolioWeb.HomeLive do
  use PortifolioWeb, :live_view

  import PortifolioWeb.CoreComponents

  alias Portifolio.{Projects, Technologies, Experiences, Certificates}
  alias Phoenix.LiveView.JS
  alias PortifolioWeb.Layouts

  @doc"""
  Prepara a home com os projetos.
  """
  def mount(_params, _session, socket) do
    {:ok, assign(socket,
      projects: Projects.list_projects(),
      technologies: Technologies.list_technologies(),
      experiences: Experiences.list_experiences(),
      certificates: Certificates.list_certificates())
    }
  end

  @doc """
  Renderiza o header para mobile e desktop
  """
  def header(assigns) do
    ~H"""
    <!-- Adicionado backdrop-blur e transparência no bg, além de uma borda inferior sutil -->
    <header class="sticky top-0 z-50 bg-base-100 border-b border-base-content/10">
      <nav class="flex items-center justify-between md:grid md:grid-cols-3 p-4 max-w-7xl mx-auto">

        <!-- 1. Fatia da Esquerda (Logo/Nome) -->
        <div class="font-bold text-2xl text-base-content md:justify-self-start">
          Ricardo Ferreira
        </div>

        <!-- 2. Fatia do Centro (Menu Desktop) -->
        <!-- Removida a borda primária (border border-primary rounded-full py-2 px-4) para um visual mais limpo -->
        <ul class="hidden gap-8 font-medium border border-primary/50 rounded-full py-2 px-6 md:justify-self-center md:flex">
          <li><a href="#about" class="hover:text-primary transition-colors duration-200">Sobre</a></li>
          <li><a href="#projects" class="hover:text-primary transition-colors duration-200">Projetos</a></li>
          <li><a href="#research" class="hover:text-primary transition-colors duration-200">Pesquisa</a></li>
          <li><a href="#technologies" class="hover:text-primary transition-colors duration-200">Tecnologias</a></li>
          <li><a href="#experiences" class="hover:text-primary transition-colors duration-200">Experiências</a></li>
          <li><a href="#certificates" class="hover:text-primary transition-colors duration-200">Certificados</a></li>
          <li><a href="#contacts" class="hover:text-primary transition-colors duration-200">Contatos</a></li>
        </ul>

        <!-- 3. Fatia da Direita (Dark Mode + Sanduíche via Dropdown) -->
        <div class="flex items-center gap-2 md:justify-self-end">
          <Layouts.theme_toggle />

          <div class="dropdown dropdown-end md:hidden">
            <div
              tabindex="0"
              role="button"
              class="btn btn-ghost btn-circle focus:outline-none"
              aria-label="Abrir menu"
            >
              <.icon name="hero-bars-3" class="w-8 h-8" />
            </div>

            <!-- Menu Mobile (Caixa Flutuante) -->
            <!-- Adicionado border/ring sutil para destacar do fundo escuro -->
            <ul
              tabindex="0"
              class="menu dropdown-content mt-3 z-[1] p-4 shadow-2xl bg-base-200 rounded-box w-72 text-lg font-medium gap-2 border border-base-300"
            >
              <li><a href="#about" onclick="this.blur()" class="hover:text-primary py-3">Sobre</a></li>
              <li><a href="#projects" onclick="this.blur()" class="hover:text-primary py-3">Projetos</a></li>
              <li><a href="#research" onclick="this.blur()" class="hover:text-primary py-3">Pesquisa</a></li>
              <li><a href="#technologies" onclick="this.blur()" class="hover:text-primary py-3">Tecnologias</a></li>
              <li><a href="#experiences" onclick="this.blur()" class="hover:text-primary py-3">Experiências</a></li>
              <li><a href="#certificates" onclick="this.blur()" class="hover:text-primary py-3">Certificados</a></li>
              <li><a href="#contacts" onclick="this.blur()" class="hover:text-primary py-3">Contatos</a></li>
            </ul>
          </div>
        </div>
      </nav>
    </header>
    """
  end

  @doc """
  Renderiza a seção "Sobre"
  """
  def about(assigns) do
    ~H"""
    <section class="grid grid-cols-1 gap-4 p-4 m-8 text-xl items-center justify-center md:grid-cols-2 md:min-h-[80vh]" id="about">
      <div class="flex items-center justify-center mx-auto">
        <div class="avatar">
          <div class="w-48 md:w-80 rounded-full">
            <img
              src="https://github.com/ricardoof.png"
              alt="Foto de Ricardo Ferreira"
            />
          </div>
        </div>
      </div>

      <div class="flex flex-col gap-4 text-center md:text-left">
        <h1 class="text-4xl font-bold">Olá, meu nome é Ricardo Ferreira</h1>

        <p>Sou estudante de Ciência da Computação na UFV (8º período) e Desenvolvedor Full Stack, apaixonado por criar softwares eficientes e escaláveis.
        Atualmente, meu grande foco é o ecossistema funcional, utilizando a linguagem de programação funcional <span class="text-primary font-semibold">Elixir</span>
        e o framework <span class="text-primary font-semibold">Phoenix</span> para escalabilidade e concorrência.</p>
      </div>
    </section>
    """
  end

  @doc """
  Renderiza meus projetos.
  """
  def projects(assigns) do
    ~H"""
    <section
      class="flex flex-col gap-4 items-center md:m-8 md:my-16"
      id="projects"
    >
      <h2 class="text-4xl font-bold mb-8">Projetos</h2>

      <div class="grid grid-cols-1 gap-8 p-4 md:grid-cols-3 md:m-8 w-full max-w-7xl">
        <div
          class={[
            "card bg-base-100 shadow-xl hover:-translate-y-2 hover:shadow-2xl transition-all duration-300 border border-base-200 dark:border-primary/30",
            index >= 3 && "hidden more-projects"
          ]}
          :for={{project, index} <- Enum.with_index(@projects)}
        >
          <figure>
            <img
              src={project.image}
              alt={project.title}
              class="w-full aspect-video object-cover object-top border-b border-base-200 dark:border-primary/20"
            />
          </figure>

          <div class="card-body p-6 flex flex-col gap-4">
            <h3 class="card-title text-2xl"><%= project.title %></h3>

            <p class="text-sm text-base-content/80 flex-grow leading-relaxed">
              <%= project.description %>
            </p>

            <div class="flex flex-wrap gap-2 mt-2">
              <span
                :for={tech <- project[:technologies] || []}
                class="badge badge-primary badge-sm font-semibold"
              >
                <%= tech %>
              </span>
            </div>

            <div class="card-actions justify-start mt-4 pt-4 border-t border-base-200 dark:border-base-content/10">
              <.link :if={project[:link_deploy] not in [nil, ""]} href={project.link_deploy} target="_blank" aria-label="Acessar Deploy" class="hover:text-primary transition-colors hover:scale-110">
                <.icon name="hero-computer-desktop" class="w-7 h-7" />
              </.link>

              <.link href={project.link_github} target="_blank" aria-label="Acessar código no GitHub" class="hover:text-primary transition-colors hover:scale-110">
                <.github_icon class="w-7 h-7" />
              </.link>
            </div>
          </div>
        </div>
      </div>

      <%= if length(@projects) > 3 do %>
        <div class="mt-8">
          <button
            id="show-more-btn"
            phx-click={JS.remove_class("hidden", to: ".more-projects") |> JS.hide()}
            class="btn btn-outline btn-primary rounded-full px-8 shadow-md hover:shadow-lg"
          >
            Mostrar mais
          </button>
        </div>
      <% end %>
    </section>
    """
  end

  @doc """
  Renderiza a seção de pesquisa.
  """
  def research(assigns) do
    ~H"""
    <section
      class="flex flex-col items-center gap-8 p-4 md:m-8 md:my-16"
      id="research"
    >
      <h2 class="text-4xl font-bold mb-8">Pesquisa</h2>

      <div class="grid grid-cols-1 md:grid-cols-2 gap-8 w-full max-w-7xl">

        <!-- Card 1: TCC -->
        <div class="card bg-base-100 shadow-xl hover:-translate-y-2 hover:shadow-2xl transition-all duration-300 border border-base-200 dark:border-primary/30">
          <figure>
            <!-- Placeholder Imagem -->
            <img
              src="https://placehold.co/800x450/191e24/a6adc8?text=TCC+em+Breve"
              alt="Placeholder TCC"
              class="w-full aspect-video object-cover object-center border-b border-base-200 dark:border-primary/20"
            />
          </figure>

          <div class="card-body p-6 flex flex-col gap-4">
            <h3 class="card-title text-2xl">Trabalho de Conclusão de Curso</h3>

            <p class="text-sm text-base-content/80 flex-grow leading-relaxed">
              Projeto final de graduação em Ciência da Computação. O tema principal e os objetivos específicos da pesquisa estão atualmente em fase de planejamento e definição.
            </p>

            <div class="flex flex-wrap gap-2 mt-2">
              <span class="badge badge-outline badge-sm">Planejamento</span>
            </div>
          </div>
        </div>

        <!-- Card 2: Iniciação Científica -->
        <div class="card bg-base-100 shadow-xl hover:-translate-y-2 hover:shadow-2xl transition-all duration-300 border border-base-200 dark:border-primary/30">
          <figure>
            <!-- Placeholder Imagem -->
            <img
              src="https://placehold.co/800x450/191e24/a6adc8?text=Iniciacao+Cientifica"
              alt="Placeholder Iniciação Científica"
              class="w-full aspect-video object-cover object-center border-b border-base-200 dark:border-primary/20"
            />
          </figure>

          <div class="card-body p-6 flex flex-col gap-4">
            <h3 class="card-title text-2xl">Iniciação Científica</h3>

            <p class="text-sm text-base-content/80 flex-grow leading-relaxed">
              Pesquisa voltada para o desenvolvimento de software utilizando a linguagem funcional Elixir e o framework Phoenix. Explorando conceitos de escalabilidade, concorrência e tolerância a falhas.
            </p>

            <div class="flex flex-wrap gap-2 mt-2">
              <span class="badge badge-primary badge-sm font-semibold">Elixir</span>
              <span class="badge badge-primary badge-sm font-semibold">Phoenix</span>
              <span class="badge badge-primary badge-sm font-semibold">TailwindCSS</span>
              <span class="badge badge-primary badge-sm font-semibold">MySQL</span>
              <span class="badge badge-primary badge-sm font-semibold">Playwright</span>
              <span class="badge badge-primary badge-sm font-semibold">K6</span>
            </div>
          </div>
        </div>
      </div>
    </section>
    """
  end

  @doc """
  Renderiza as tecnologias que domino e utilizo em meus projetos.
  """
  def technologies(assigns) do
    ~H"""
    <section
      class="flex flex-col items-center gap-8 p-4 md:my-16 w-full max-w-7xl mx-auto"
      id="technologies"
    >
      <h2 class="text-4xl font-bold mb-8">Tecnologias</h2>

      <ul
        class="flex flex-wrap justify-center items-center gap-8 md:gap-12"
        aria-label="Lista de tecnologias que utilizo"
      >
        <li :for={technology <- @technologies} class="group">
          <div class="tooltip tooltip-primary" data-tip={technology.alt}>
            <div class="h-12 w-12 md:h-16 md:w-16 transition-transform duration-300 group-hover:scale-110 group-hover:-translate-y-2 cursor-pointer">
              <img
                src={technology.image}
                class="w-full h-full object-contain"
                alt={technology.alt}
              />
            </div>
          </div>
        </li>
      </ul>
    </section>
    """
  end

  @doc """
  Renderiza as minhas experiências profissionais.
  """
  def experiences(assigns) do
    ~H"""
    <section
      class="flex flex-col gap-8 items-center md:m-8 md:my-16"
      id="experiences"
    >
      <h2 class="text-4xl font-bold">Experiências</h2>

      <div class="w-full max-w-3xl p-4">
        <ul class="timeline timeline-snap-icon timeline-compact timeline-vertical">
          <li :for={{experience, index} <- Enum.with_index(@experiences)}>
            <hr :if={index > 0} />

            <div class="timeline-middle text-primary">
              <svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 20 20" fill="currentColor" class="w-5 h-5" aria-hidden="true">
                <path fill-rule="evenodd" d="M10 18a8 8 0 100-16 8 8 0 000 16zm3.857-9.809a.75.75 0 00-1.214-.882l-3.483 4.79-1.88-1.88a.75.75 0 10-1.06 1.061l2.5 2.5a.75.75 0 001.137-.089l4-5.5z" clip-rule="evenodd" />
              </svg>
            </div>

            <div class="timeline-end mb-10 ml-4 md:ml-6">
              <time class="font-mono text-sm text-base-content/50 mb-1 block">
                <%= experience.period %> &bull; <%= experience.location %>
              </time>

              <h3 class="text-xl font-bold"><%= experience.role %></h3>

              <h4 class="text-lg font-medium text-base-content/80 mb-3">
                <.link
                  href={experience.company_link}
                  target="_blank"
                  rel="noopener noreferrer"
                  class="inline-flex items-center gap-1.5 underline underline-offset-4 decoration-base-content/30 hover:text-primary hover:decoration-primary transition-colors duration-200"
                >
                  <%= experience.company %>
                </.link>
              </h4>

              <p class="text-sm text-base-content/70 mb-4 leading-relaxed">
                <%= experience.description %>
              </p>

              <div class="flex flex-wrap gap-2">
                <span
                  :for={tech <- experience[:technologies] || []}
                  class="badge badge-outline badge-primary badge-sm"
                >
                  <%= tech %>
                </span>
              </div>
            </div>

            <hr :if={index < length(@experiences) - 1} />
          </li>
        </ul>
      </div>
    </section>
    """
  end

  @doc """
  Renderiza meus certificados
  """
  def certificates(assigns) do
    ~H"""
    <section class="flex flex-col items-center gap-8 md:m-8 md:my-16 p-4" id="certificates">
      <h2 class="text-4xl font-bold">Certificados</h2>

      <div class="w-full max-w-3xl">
        <ul class="flex flex-col gap-3" aria-label="Lista de certificados que obtive">
          <li :for={certificate <- @certificates}>
            <.link
              href={certificate.link}
              target="_blank"
              rel="noopener noreferrer"
              class="block p-4 rounded-lg bg-base-200 hover:bg-base-300 hover:text-primary text-base font-medium transition-colors duration-200"
            >
              <%= certificate.name %>
            </.link>
          </li>
        </ul>
      </div>
    </section>
    """
  end

  @doc """
  Renderiza os contatos
  """
  def contacts(assigns) do
    ~H"""
    <section
      class="flex flex-col items-center gap-12 p-4 md:my-16"
      id="contacts"
    >
      <h2 class="text-4xl">Contatos</h2>

      <ul class="flex flex-row items-center gap-6" aria-label="Links para minhas redes sociais e contato">
        <li class="w-8 h-8 hover:text-primary transition-colors duration-200">
          <.link href="https://www.linkedin.com/in/ricardoof/" target="_blank" rel="noopener noreferrer" title="LinkedIn" aria-label="LinkedIn">
           <.linkedin_icon class="h-full w-full" aria-hidden="true" />
          </.link>
        </li>

        <li class="w-8 h-8 hover:text-primary transition-colors duration-200">
          <.link href="mailto:ricardoferreira4496@gmail.com" target="_blank" rel="noopener noreferrer" title="Email" aria-label="Email">
            <.icon name="hero-envelope" class="h-full w-full" />
          </.link>
        </li>

        <li class="w-8 h-8 hover:text-primary transition-colors duration-200">
          <.link href="https://github.com/ricardoof" target="_blank" rel="noopener noreferrer" title="GitHub" aria-label="GitHub">
            <.github_icon class="h-full w-full" aria-hidden="true" />
          </.link>
        </li>

        <li class="w-8 h-8 hover:text-primary transition-colors duration-200">
          <.link href="https://x.com/rricardoof" target="_blank" rel="noopener noreferrer" title="X (Twitter)" aria-label="X (Twitter)">
            <.twitter_icon class="h-full w-full" aria-hidden="true" />
          </.link>
        </li>

        <li class="w-8 h-8 hover:text-primary transition-colors duration-200">
          <.link href="https://www.instagram.com/rricardoferreiraa" target="_blank" rel="noopener noreferrer" title="Instagram" aria-label="Instagram">
            <.instagram_icon class="h-full w-full" aria-hidden="true" />
          </.link>
        </li>

        <li class="w-8 h-8 hover:text-primary transition-colors duration-200">
          <.link href="https://bsky.app/profile/ricardoof.bsky.social" target="_blank" rel="noopener noreferrer" title="Bluesky" aria-label="Bluesky">
            <.bluesky_icon class="h-full w-full" aria-hidden="true" />
          </.link>
        </li>
      </ul>
    </section>
    """
  end

  defp linkedin_icon(assigns) do
    ~H"""
    <svg
      xmlns="http://www.w3.org/2000/svg"
      viewBox="0 0 448 512"
      class={["fill-current", assigns[:class]]}
    >
      <path d="M416 32L31.9 32C14.3 32 0 46.5 0 64.3L0 447.7C0 465.5 14.3 480 31.9 480L416 480c17.6 0 32-14.5 32-32.3l0-383.4C448 46.5 433.6 32 416 32zM135.4 416l-66.4 0 0-213.8 66.5 0 0 213.8-.1 0zM102.2 96a38.5 38.5 0 1 1 0 77 38.5 38.5 0 1 1 0-77zM384.3 416l-66.4 0 0-104c0-24.8-.5-56.7-34.5-56.7-34.6 0-39.9 27-39.9 54.9l0 105.8-66.4 0 0-213.8 63.7 0 0 29.2 .9 0c8.9-16.8 30.6-34.5 62.9-34.5 67.2 0 79.7 44.3 79.7 101.9l0 117.2z"/>
    </svg>
    """
  end

  defp instagram_icon(assigns) do
    ~H"""
    <svg
      xmlns="http://www.w3.org/2000/svg"
      viewBox="0 0 448 512"
      class={["fill-current", assigns[:class]]}
    >
      <path d="M224.3 141a115 115 0 1 0 -.6 230 115 115 0 1 0 .6-230zm-.6 40.4a74.6 74.6 0 1 1 .6 149.2 74.6 74.6 0 1 1 -.6-149.2zm93.4-45.1a26.8 26.8 0 1 1 53.6 0 26.8 26.8 0 1 1 -53.6 0zm129.7 27.2c-1.7-35.9-9.9-67.7-36.2-93.9-26.2-26.2-58-34.4-93.9-36.2-37-2.1-147.9-2.1-184.9 0-35.8 1.7-67.6 9.9-93.9 36.1s-34.4 58-36.2 93.9c-2.1 37-2.1 147.9 0 184.9 1.7 35.9 9.9 67.7 36.2 93.9s58 34.4 93.9 36.2c37 2.1 147.9 2.1 184.9 0 35.9-1.7 67.7-9.9 93.9-36.2 26.2-26.2 34.4-58 36.2-93.9 2.1-37 2.1-147.8 0-184.8zM399 388c-7.8 19.6-22.9 34.7-42.6 42.6-29.5 11.7-99.5 9-132.1 9s-102.7 2.6-132.1-9c-19.6-7.8-34.7-22.9-42.6-42.6-11.7-29.5-9-99.5-9-132.1s-2.6-102.7 9-132.1c7.8-19.6 22.9-34.7 42.6-42.6 29.5-11.7 99.5-9 132.1-9s102.7-2.6 132.1 9c19.6 7.8 34.7 22.9 42.6 42.6 11.7 29.5 9 99.5 9 132.1s2.7 102.7-9 132.1z"/>
    </svg>
    """
  end

  defp twitter_icon(assigns) do
    ~H"""
    <svg
      xmlns="http://www.w3.org/2000/svg"
      viewBox="0 0 448 512"
      class={["fill-current", assigns[:class]]}
    >
      <path d="M357.2 48L427.8 48 273.6 224.2 455 464 313 464 201.7 318.6 74.5 464 3.8 464 168.7 275.5-5.2 48 140.4 48 240.9 180.9 357.2 48zM332.4 421.8l39.1 0-252.4-333.8-42 0 255.3 333.8z"/>
    </svg>
    """
  end

  defp bluesky_icon(assigns) do
    ~H"""
    <svg
      xmlns="http://www.w3.org/2000/svg"
      viewBox="0 0 576 512"
      class={["fill-current", assigns[:class]]}
    >
      <path d="M407.8 294.7c-3.3-.4-6.7-.8-10-1.3 3.4 .4 6.7 .9 10 1.3zM288 227.1C261.9 176.4 190.9 81.9 124.9 35.3 61.6-9.4 37.5-1.7 21.6 5.5 3.3 13.8 0 41.9 0 58.4S9.1 194 15 213.9c19.5 65.7 89.1 87.9 153.2 80.7 3.3-.5 6.6-.9 10-1.4-3.3 .5-6.6 1-10 1.4-93.9 14-177.3 48.2-67.9 169.9 120.3 124.6 164.8-26.7 187.7-103.4 22.9 76.7 49.2 222.5 185.6 103.4 102.4-103.4 28.1-156-65.8-169.9-3.3-.4-6.7-.8-10-1.3 3.4 .4 6.7 .9 10 1.3 64.1 7.1 133.6-15.1 153.2-80.7 5.9-19.9 15-138.9 15-155.5s-3.3-44.7-21.6-52.9c-15.8-7.1-40-14.9-103.2 29.8-66.1 46.6-137.1 141.1-163.2 191.8z"/>
    </svg>
    """
  end

  defp github_icon(assigns) do
    ~H"""
    <svg
      xmlns="http://www.w3.org/2000/svg"
      viewBox="0 0 512 512"
      class={["fill-current", assigns[:class]]}
    >
      <path d="M216.5 362.5c-66-8-112.5-55.5-112.5-117 0-25 9-52 24-70-6.5-16.5-5.5-51.5 2-66 20-2.5 47 8 63 22.5 19-6 39-9 63.5-9s44.5 3 62.5 8.5c15.5-14 43-24.5 63-22 7 13.5 8 48.5 1.5 65.5 16 19 24.5 44.5 24.5 70.5 0 61.5-46.5 108-113.5 116.5 17 11 28.5 35 28.5 62.5l0 52C323 491.5 335.5 500 350.5 494 441 459.5 512 369 512 257 512 115.5 397 0 255.5 0S0 115.5 0 257c0 111 70.5 203 165.5 237.5 13.5 5 26.5-4 26.5-17.5l0-40c-7 3-16 5-24 5-33 0-52.5-18-66.5-51.5-5.5-13.5-11.5-21.5-23-23-6-.5-8-3-8-6 0-6 10-10.5 20-10.5 14.5 0 27 9 40 27.5 10 14.5 20.5 21 33 21s20.5-4.5 32-16c8.5-8.5 15-16 21-21z"/>
    </svg>
    """
  end

  @doc """
  Renderiza o footer
  """
  def footer(assigns) do
    ~H"""
    <footer class="w-full flex justify-center items-center p-8 mt-16 text-sm opacity-75 border-t border-base-content/10">
      <p>&copy; <%= Date.utc_today().year %> Ricardo Ferreira. Todos os direitos reservados.</p>
    </footer>
    """
  end
end
