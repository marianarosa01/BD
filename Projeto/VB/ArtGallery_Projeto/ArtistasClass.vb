Public Class ArtistasClass
    Private _id_Artista As Integer
    Private _Nome As String
    Private _DataNascimento As String
    Private _DataObito As String
    Private _Especialidade As String


    Property idArtista() As Integer
        Get
            Return _id_Artista
        End Get
        Set(ByVal value As Integer)
            _id_Artista = value
        End Set
    End Property
    Property Especialidade() As String
        Get
            Return _Especialidade

        End Get
        Set(ByVal value As String)
            _Especialidade = value
        End Set
    End Property
    Property Nome() As String
        Get
            Return _Nome
        End Get
        Set(ByVal value As String)
            _Nome = value
        End Set
    End Property
    Property DataNascimento() As String
        Get
            Return _DataNascimento
        End Get
        Set(ByVal value As String)
            _DataNascimento = value
        End Set
    End Property
    Property DataObito() As String
        Get
            Return _DataObito

        End Get
        Set(ByVal value As String)
            _DataObito = value
        End Set
    End Property

    Overrides Function ToString() As String
        Return _Nome

    End Function

    End Class

