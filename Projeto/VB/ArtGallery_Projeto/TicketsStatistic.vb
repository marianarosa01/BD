Imports System.Data.SqlClient


Public Class TicketsStatistic
    Dim CN As SqlConnection
    Dim CMD As SqlCommand
    Dim dbServer = "tcp:mednat.ieeta.pt\SQLSERVER,8101"
    Dim dbName = "p3g1"
    Dim username = "p3g1"
    Dim userPass = "TheBest123"

    Public Shared Property listaFuncionarios As New List(Of Funcionarios)
    Private Sub ListView1_SelectedIndexChanged(sender As Object, e As EventArgs)

    End Sub

    Private Sub TicketsStatistic_Load(sender As Object, e As EventArgs) Handles MyBase.Load
        CMD = New SqlCommand
        CN = New SqlConnection("data Source= " + dbServer + ";" + "initial Catalog = " + dbName + ";" + "uid = " + username + ";" + "password = " + userPass)
        CMD.Connection = CN
        'por referencia
        CMD.CommandText = "
            Select *
            From ArtGallery.PeopleWithAnualTickets)"

        Dim RDR As SqlDataReader
        CN.Open()
        RDR = CMD.ExecuteReader()

    End Sub
End Class