Public Class ObrasDeArteClasses

    Private _referencia As Integer
    Private _DataProducao As String
    Private _Valor As Integer
    Private _Descricao As String
    Private _Titulo As String
    Private _FKExposicaoNome As String
    Private _FKArtista As String
    Private _NumSala As Integer
    Private _NomeArtista As String

    Property referencia() As Integer
        Get
            Return _referencia
        End Get
        Set(ByVal value As Integer)
            _referencia = value
        End Set
    End Property
    Property Valor() As Integer
        Get
            Return _Valor
        End Get
        Set(ByVal value As Integer)
            _Valor = value
        End Set
    End Property

    Property DataProducao() As String
        Get
            Return _DataProducao
        End Get
        Set(ByVal value As String)
            _DataProducao = value
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

    Property FKArtista() As String
        Get
            Return _FKArtista

        End Get
        Set(ByVal value As String)
            _FKArtista = value
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

    Property NomeArtista() As String
        Get
            Return _NomeArtista

        End Get
        Set(ByVal value As String)
            _NomeArtista = value
        End Set
    End Property
    Overrides Function ToString() As String
        Return _Titulo & "     |     " & _NomeArtista & "     |     " & _FKExposicaoNome & "     |     " & _NumSala

    End Function

End Class
