using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Data.SqlClient;
using System.Drawing;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows.Forms;

namespace HASTANEeee
{
    public partial class DoktorEkle : Form
    {
        public DoktorEkle()
        {
            InitializeComponent();
        }

        SqlConnection baglanti;
        SqlCommand komut;
        SqlConnection baglanti2 = new SqlConnection("Data Source=DESKTOP-0M417A5;Initial Catalog=hastane;Integrated Security=True");
        SqlDataAdapter da;

        void doktorBilgiGetir()
        {
            baglanti = new SqlConnection("Data Source=DESKTOP-0M417A5;Initial Catalog=hastane;Integrated Security=True");
            baglanti.Open();
            da = new SqlDataAdapter("SELECT doktorID, doktorAdiSoyadi, poliklinikAdi,poliklinikID\r\nFROM DoktorView3;", baglanti);
            DataTable tablo = new DataTable();
            da.Fill(tablo);
            dataGridView1.DataSource = tablo;
            baglanti.Close();
        }

        private void DoktorEkle_Load(object sender, EventArgs e)
        {
            doktorBilgiGetir();
            SqlCommand komut2 = new SqlCommand("select * from poliklinikler", baglanti2);
            SqlDataReader dr;
            baglanti2.Open();
            dr = komut2.ExecuteReader();
            while (dr.Read())
            {
                comboBox1.Items.Add(dr["poliklinikID"]);
            }
            baglanti2.Close();
        }

        private void dataGridView1_CellEnter(object sender, DataGridViewCellEventArgs e)
        {
            textBox1.Text = dataGridView1.CurrentRow.Cells[0].Value.ToString();
            //textBox4.Text = dataGridView1.CurrentRow.Cells[2].Value.ToString();
            textBox2.Text = dataGridView1.CurrentRow.Cells[1].Value.ToString();
            comboBox1.Text = dataGridView1.CurrentRow.Cells[3].Value.ToString();
        }

        private void button1_Click(object sender, EventArgs e)
        {
            string sorgu = "insert ddoktorlar(Sifre,doktorAdiSoyadi,poliklinikID) values(@Sifre,@doktorAdiSoyAdi,@poliklinikID)";
            komut = new SqlCommand(sorgu, baglanti);
            komut.Parameters.AddWithValue("@Sifre", textBox4.Text);

            komut.Parameters.AddWithValue("doktorAdiSoyAdi", textBox2.Text);
            komut.Parameters.AddWithValue("@poliklinikID", Convert.ToString(comboBox1.Text));
            baglanti.Open();
            komut.ExecuteNonQuery();
            MessageBox.Show("Başarıyla Eklendi");
            baglanti.Close();
            doktorBilgiGetir();
        }

        private void button2_Click(object sender, EventArgs e)
        {
            string sorgu = "delete from ddoktorlar where doktorID = @doktorID";
            komut = new SqlCommand(sorgu, baglanti);
            komut.Parameters.AddWithValue("@doktorID", Convert.ToInt32(textBox1.Text));
            baglanti.Open();
            komut.ExecuteNonQuery();
            MessageBox.Show("Başarıyla Silindi");
            baglanti.Close();
            doktorBilgiGetir();
        }

        private void button3_Click(object sender, EventArgs e)
        {
            baglanti.Open();
            komut = new SqlCommand("doktorGüncelle2", baglanti);
            komut.CommandType = CommandType.StoredProcedure;
            komut.Parameters.AddWithValue("doktorID", textBox1.Text);
            komut.Parameters.AddWithValue("Sifre", textBox4.Text);
            komut.Parameters.AddWithValue("doktorAdiSoyadi", textBox2.Text);
            komut.Parameters.AddWithValue("poliklinikID", comboBox1.Text);
            komut.ExecuteNonQuery();
            baglanti.Close();
            MessageBox.Show("Güncelleme Yapılmıştır");
            doktorBilgiGetir();

        }

        private void button4_Click(object sender, EventArgs e)
        {
            formlar.formPersonelGirişEkranı.Show();
            this.Hide();
        }

        private void textBox1_TextChanged(object sender, EventArgs e)
        {

        }

        private void textBox2_TextChanged(object sender, EventArgs e)
        {

        }

        private void textBox4_TextChanged(object sender, EventArgs e)
        {

        }
    }
}
