Public Class FilmesClass
    Private _referencia As Integer
    Private _Descricao As String
    Private _Titulo As String
    Private _FKExposicaoNome As String
    Private _NumSala As Integer
    Private _Genero As String
    Private _Duracao As String
    Private _Realizador As String
    Private _Elenco As String
    Private _DataProducao As String

    Property DataProducao() As String
        Get
            Return _DataProducao
        End Get
        Set(ByVal value As String)
            _DataProducao = value
        End Set
    End Property
    Property referencia() As Integer
        Get
            Return _referencia
        End Get
        Set(ByVal value As Integer)
            _referencia = value
        End Set
    End Property
    Property Genero() As String
        Get
            Return _Genero
        End Get
        Set(ByVal value As String)
            _Genero = value
        End Set
    End Property
    Property Duracao() As String
        Get
            Return _Duracao
        End Get
        Set(ByVal value As String)
            _Duracao = value
        End Set
    End Property

    Property Realizador() As String
        Get
            Return _Realizador
        End Get
        Set(ByVal value As String)
            _Realizador = value
        End Set
    End Property

    Property Titulo() As String
        Get
            Return _Titulo
        End Get
        Set(ByVal value As String)
            _Titulo = value
        End Set
    End Property

    Property Descricao() As String
        Get
            Return _Descricao
        End Get
        Set(ByVal value As String)
            _Descricao = value
        End Set
    End Property

    Property FKExposicaoNome() As String
        Get
            Return _FKExposicaoNome

        End Get
        Set(ByVal value As String)
            _FKExposicaoNome = value
        End Set
    End Property
    Property NumSala() As Integer
        Get
            Return _NumSala
        End Get
        Set(ByVal value As Integer)
            _NumSala = value
        End Set
    End Property

    Property Elenco() As String
        Get
            Return _Elenco

        End Get
        Set(ByVal value As String)
            _Elenco = value
        End Set
    End Property

    Overrides Function ToString() As String
        Return _Titulo

    End Function

End Class
