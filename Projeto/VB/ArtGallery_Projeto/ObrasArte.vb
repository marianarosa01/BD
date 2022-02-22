Imports System.Data.SqlClient


Public Class ObrasArte
    Dim CN As SqlConnection
    Dim CMD As SqlCommand
    Dim dbServer = "tcp:mednat.ieeta.pt\SQLSERVER,8101"
    Dim dbName = "p3g1"
    Dim username = "p3g1"
    Dim userPass = "TheBest123"
    Public Shared Property listaObras As New List(Of ObrasDeArteClasses)

    Private Sub ObrasArte_Load(sender As Object, e As EventArgs) Handles MyBase.Load
        CMD = New SqlCommand
        CN = New SqlConnection("data Source= " + dbServer + ";" + "initial Catalog = " + dbName + ";" + "uid = " + username + ";" + "password = " + userPass)
        CMD.Connection = CN

        CMD.CommandText = "
            SELECT  Referencia, Titulo, Nome, Data_Producao, Valor, Descricao, Titulo, FK_Exposicao_Nome, FK_Artista, Num_sala
            FROM ArtGallery.ObrasDeArtes JOIN ArtGallery.Artista ON ID_Artista=FK_Artista"

        Dim RDR As SqlDataReader

        CN.Open()

        RDR = CMD.ExecuteReader()
        While RDR.Read
            Dim ObraArte As New ObrasDeArteClasses
            ObraArte.referencia = RDR.Item("Referencia")
            ObraArte.DataProducao = RDR.Item("Data_Producao")
            If IsDBNull(RDR.Item("Valor")) Then
                ObraArte.Valor = Nothing
            Else
                ObraArte.Valor = RDR.Item("Valor")
            End If

            If IsDBNull(RDR.Item("Descricao")) Then
                ObraArte.Descricao = Nothing
            Else
                ObraArte.Descricao = RDR.Item("Descricao")
            End If
            ObraArte.Titulo = RDR.Item("Titulo")
            ObraArte.FKExposicaoNome = RDR.Item("FK_Exposicao_Nome")

            If IsDBNull(RDR.Item("Nome")) Then
                ObraArte.FKArtista = Nothing
            Else
                ObraArte.NomeArtista = RDR.Item("Nome")
            End If


            ObraArte.NumSala = RDR.Item("Num_sala")
            listaObras.Add(ObraArte)
            ListBox1.Items.Add(ObraArte)

        End While

        RDR.Close()
        CN.Close()


    End Sub

    Private Sub ListBox1_SelectedIndexChanged(sender As Object, e As EventArgs) Handles ListBox1.SelectedIndexChanged

    End Sub

    Private Sub Label1_Click(sender As Object, e As EventArgs) Handles Label1.Click

    End Sub

    Private Sub TextBox1_TextChanged(sender As Object, e As EventArgs) Handles TextBox1.TextChanged

    End Sub

    Private Sub Button1_Click(sender As Object, e As EventArgs) Handles Button1.Click
        'Search for title of a masterpiece


        ListBox1.Items.Clear()

        Dim searchMasterpiece As String

        searchMasterpiece = TextBox1.Text


        ListBox1.Items.Clear()
        For i As Integer = 0 To listaObras.Count - 1
            If listaObras(i).Titulo.Contains(searchMasterpiece) Then
                ListBox1.Items.Add(listaObras(i))
            End If
        Next


    End Sub

    Private Sub Label3_Click(sender As Object, e As EventArgs) Handles Label3.Click

    End Sub

    Private Sub Label2_Click(sender As Object, e As EventArgs) Handles Label2.Click

    End Sub



    Private Sub TextBox2_TextChanged(sender As Object, e As EventArgs) Handles TextBox2.TextChanged

    End Sub

    Private Sub Button2_Click(sender As Object, e As EventArgs) Handles Button2.Click
        'Search Artist
        ListBox1.Items.Clear()

        Dim searchArtist As String

        searchArtist = TextBox2.Text


        ListBox1.Items.Clear()
        For i As Integer = 0 To listaObras.Count - 1
            If listaObras(i).NomeArtista.Contains(searchArtist) Then
                ListBox1.Items.Add(listaObras(i))
            End If
        Next


    End Sub

    Private Sub Label4_Click(sender As Object, e As EventArgs)

    End Sub

    Private Sub Label5_Click(sender As Object, e As EventArgs)

    End Sub

    Private Sub Label6_Click(sender As Object, e As EventArgs)

    End Sub

    Private Sub Button3_Click(sender As Object, e As EventArgs) Handles Button3.Click
        Dim Rececionista_back = New Rececionista
        Rececionista_back.Show()
        Me.Hide()
    End Sub
End Class