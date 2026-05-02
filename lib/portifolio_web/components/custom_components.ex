defmodule PortifolioWeb.CustomComponents do
  use Phoenix.Component
  #use Gettext, backend: PortifolioWeb.Gettext

  #alias Phoenix.LiveView.JS

  def header(assigns) do
    ~H"""
    <header>

    </header>
    """
  end

  def about(assigns) do
    ~H"""
    <section>
      <h1>Olá, meu nome é Ricardo Ferreira</h1>

      <p>Sou estudante de Ciência da Computação na UFV (7º período) e Desenvolvedor Full Stack, apaixonado por criar softwares eficientes e escaláveis.

      Atualmente, meu grande foco é o ecossistema funcional. Na minha Iniciação Científica, utilizo Elixir e Phoenix para resolver desafios reais de engenharia: estou atuando na otimização de desempenho e na redução de custos de infraestrutura de servidores para o software da empresa MedYes.

      Além do código, acredito no impacto social da tecnologia. Sou membro de um projeto de extensão universitária onde ensino educação e segurança digital para idosos, o que me ensina diariamente sobre empatia, paciência e comunicação clara — habilidades essenciais para qualquer equipe de tecnologia.
      </p>
    </section>
    """
  end
end
