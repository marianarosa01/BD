Imports System.Data.SqlClient

Public Class Filmes
    Dim CN As SqlConnection
    Dim CMD As SqlCommand
    Dim dbServer = "tcp:mednat.ieeta.pt\SQLSERVER,8101"
    Dim dbName = "p3g1"
    Dim username = "p3g1"
    Dim userPass = "TheBest123"

    Public Shared Property listaFilmes As New List(Of FilmesClass)
    Private Sub Filmes_Load(sender As Object, e As EventArgs) Handles MyBase.Load
        CMD = New SqlCommand
        CN = New SqlConnection("data Source= " + dbServer + ";" + "initial Catalog = " + dbName + ";" + "uid = " + username + ";" + "password = " + userPass)
        CMD.Connection = CN
        'por referencia
        CMD.CommandText = " SELECT ArtGallery.ObrasDeArtes.Referencia, Titulo, Data_Producao, Descricao, FK_Exposicao_Nome, Num_sala, Genero, Duracao, Realizador, Elenco
FROM (ArtGallery.ObrasDeArtes JOIN ArtGallery.Filme ON ArtGallery.ObrasDeArtes.Referencia=ArtGallery.Filme.Referencia) "


        Dim RDR As SqlDataReader
        CN.Open()
        RDR = CMD.ExecuteReader()


        While RDR.Read
            Dim Filmes As New FilmesClass

            Filmes.DataProducao = RDR.Item("Data_Producao")

            If IsDBNull(RDR.Item("Descricao")) Then
                Filmes.Descricao = Nothing
            Else
                Filmes.Descricao = RDR.Item("Descricao")
            End If
            Filmes.Titulo = RDR.Item("Titulo")
            Filmes.referencia = RDR.Item("Referencia")
            Filmes.Realizador = RDR.Item("Realizador")
            Filmes.Duracao = RDR.Item("Duracao")
            Filmes.NumSala = RDR.Item("Num_sala")
            Filmes.FKExposicaoNome = RDR.Item("FK_Exposicao_Nome")
            Filmes.Genero = RDR.Item("Genero")
            Filmes.Elenco = RDR.Item("Elenco")


            listaFilmes.Add(Filmes)
            ListBox1.Items.Add(Filmes)
        End While


        RDR.Close()
        CN.Close()

    End Sub




    Private Sub ListBox1_SelectedIndexChanged(sender As Object, e As EventArgs) Handles ListBox1.SelectedIndexChanged
        Dim index = ListBox1.SelectedIndex
        Dim P = listaFilmes(index)

        TextBox1.Text = P.Titulo
        TextBox2.Text = P.referencia
        TextBox3.Text = P.DataProducao
        TextBox4.Text = P.FKExposicaoNome
        TextBox5.Text = P.Duracao
        TextBox6.Text = P.Genero
        TextBox7.Text = P.Descricao
        TextBox9.Text = P.Realizador
        TextBox10.Text = P.NumSala


    End Sub

    Private Sub Label8_Click(sender As Object, e As EventArgs) Handles Label8.Click

    End Sub

    Private Sub TextBox2_TextChanged(sender As Object, e As EventArgs) Handles TextBox2.TextChanged

    End Sub

    Private Sub Button1_Click(sender As Object, e As EventArgs) Handles Button1.Click
        Dim Secretaria_back = New Secretaria
        Secretaria_back.Show()
        Me.Hide()
    End Sub

    Private Sub Button2_Click(sender As Object, e As EventArgs) Handles Button2.Click
        Dim index As Integer = ListBox1.SelectedIndex
        Dim esc = ListBox1.Items(index)

        Dim ref = esc.referencia

        Dim CMD As New SqlCommand
        CMD.Connection = CN
        CMD.CommandText = "[ApagarObraDeArte]"
        CMD.CommandType = CommandType.StoredProcedure

        CMD.Parameters.Add("@expression", SqlDbType.Int).Value = CInt(ref)
        CN.Open()
        Try
            CMD.ExecuteNonQuery()
        Catch ex As Exception
            Throw New Exception("Failed to delete movie. " & vbCrLf & "ERROR MESSAGE: " & vbCrLf & ex.Message)
            'MessageBox.Show("Nenhum visitante selecionado")
        Finally
            MessageBox.Show("Filme Apagado")
            listaFilmes.Remove(esc)
            ListBox1.Items.Remove(esc)
            CN.Close()
        End Try
    End Sub
End Class