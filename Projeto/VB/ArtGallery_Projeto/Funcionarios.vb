Public Class Funcionarios

    Private _NIF As Integer
    Private _NumFunc As Integer
    Private _Name As String
    Private _DataNasc As String
    Private _Address As String




    Property dataNasci() As String
        Get
            Return _DataNasc
        End Get
        Set(ByVal value As String)
            _DataNasc = value
        End Set
    End Property

    Property address() As String
        Get
            Return _Address
        End Get
        Set(ByVal value As String)
            _Address = value
        End Set
    End Property



    Property nif() As Integer
        Get
            Return _NIF
        End Get
        Set(ByVal value As Integer)
            _NIF = value
        End Set
    End Property
    Property numfunc() As Integer
        Get
            Return _NumFunc
        End Get
        Set(ByVal value As Integer)
            _NumFunc = value
        End Set
    End Property

    Property Name() As String
        Get
            Return _Name
        End Get
        Set(ByVal value As String)
            _Name = value
        End Set
    End Property

    Overrides Function ToString() As String
        Return _Name & "    |     " & _NIF & "     |     " & _NumFunc & " |     " & _DataNasc & "     |     " & _Address

    End Function

End Class
