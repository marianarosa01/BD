Imports System.Data.SqlClient

Public Class Esculturas_DB
    Dim CN As SqlConnection
    Dim CMD As SqlCommand
    Dim dbServer = "tcp:mednat.ieeta.pt\SQLSERVER,8101"
    Dim dbName = "p3g1"
    Dim username = "p3g1"
    Dim userPass = "TheBest123"

    Public Shared Property listaEsculturas As New List(Of EsculturasClasse)

    Private Sub Esculturas_DB_Load(sender As Object, e As EventArgs) Handles MyBase.Load
        CMD = New SqlCommand
        CN = New SqlConnection("data Source= " + dbServer + ";" + "initial Catalog = " + dbName + ";" + "uid = " + username + ";" + "password = " + userPass)
        CMD.Connection = CN
        'por referencia
        CMD.CommandText = "
         
        SELECT ArtGallery.Escultura.Referencia, Titulo, Nome AS Artista, Data_Producao, Valor, Descricao, FK_Exposicao_Nome, FK_Artista, Num_sala, Tecnica, Material
        FROM (ArtGallery.ObrasDeArtes JOIN ArtGallery.Artista ON ID_Artista=FK_Artista) JOIN ArtGallery.Escultura ON ArtGallery.ObrasDeArtes.Referencia = ArtGallery.Escultura.Referencia"

        Dim RDR As SqlDataReader
        CN.Open()
        RDR = CMD.ExecuteReader()


        While RDR.Read
            Dim Esculturas As New EsculturasClasse

            Esculturas.referencia = RDR.Item("referencia")
            Esculturas.DataProducao = RDR.Item("Data_Producao")
            If IsDBNull(RDR.Item("Valor")) Then
                Esculturas.Valor = Nothing
            Else
                Esculturas.Valor = RDR.Item("Valor")
            End If

            If IsDBNull(RDR.Item("Descricao")) Then
                Esculturas.Descricao = Nothing
            Else
                Esculturas.Descricao = RDR.Item("Descricao")
            End If
            Esculturas.Titulo = RDR.Item("Titulo")
            Esculturas.FKExposicaoNome = RDR.Item("FK_Exposicao_Nome")

            If IsDBNull(RDR.Item("Artista")) Then
                Esculturas.NomeArtista = Nothing
            Else
                Esculturas.NomeArtista = RDR.Item("Artista")
            End If

            Esculturas.NumSala = RDR.Item("Num_sala")
            Esculturas.Tecnica = RDR.Item("Tecnica")
            Esculturas.Material = RDR.Item("Material")

            listaEsculturas.Add(Esculturas)
            ListBox1.Items.Add(Esculturas)

        End While

        RDR.Close()
        CN.Close()

    End Sub



    Private Sub ListBox1_SelectedIndexChanged(sender As Object, e As EventArgs) Handles ListBox1.SelectedIndexChanged
        Dim index = ListBox1.SelectedIndex
        Dim Esc = listaEsculturas(index)

        TextBox1.Text = Esc.Titulo
        TextBox2.Text = Esc.NomeArtista
        TextBox3.Text = Esc.DataProducao
        TextBox4.Text = Esc.Descricao
        TextBox5.Text = Esc.Valor
        TextBox6.Text = Esc.Tecnica
        TextBox7.Text = Esc.Material
        TextBox9.Text = Esc.FKExposicaoNome
        TextBox10.Text = Esc.NumSala

    End Sub

    Private Sub CancelB_Click(sender As Object, e As EventArgs) Handles CancelB.Click

    End Sub

    Private Sub Button1_Click(sender As Object, e As EventArgs) Handles Button1.Click
        Dim Secretaria_back = New Secretaria
        Secretaria_back.Show()
        Me.Hide()
    End Sub

    Private Sub DeleteBut_Click(sender As Object, e As EventArgs) Handles DeleteBut.Click
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
            Throw New Exception("Failed to add escultura. " & vbCrLf & "ERROR MESSAGE: " & vbCrLf & ex.Message)
            'MessageBox.Show("Nenhum visitante selecionado")
        Finally
            MessageBox.Show("Escultura Apagada")
            listaEsculturas.Remove(esc)
            ListBox1.Items.Remove(esc)
            CN.Close()
        End Try

    End Sub
End Class