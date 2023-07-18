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
    public partial class PoliklinikEkle : Form
    {
        public PoliklinikEkle()
        {
            InitializeComponent();
        }
        SqlConnection baglanti;
        SqlCommand komut;
        SqlDataAdapter da;

        void poliklinikBilgiGetir()
        {
            baglanti = new SqlConnection("Data Source=DESKTOP-0M417A5;Initial Catalog=hastane;Integrated Security=True");
            baglanti.Open();
            da = new SqlDataAdapter("select * from polikliniklerview", baglanti);
            DataTable tablo = new DataTable();
            da.Fill(tablo);
            dataGridView1.DataSource = tablo;
            baglanti.Close();
        }
        private void button3_Click(object sender, EventArgs e)
        {
            formlar.formPersonelGirişEkranı.Show();
            this.Hide();
        }

        private void PoliklinikEkle_Load(object sender, EventArgs e)
        {
            poliklinikBilgiGetir();
        }

        private void dataGridView1_CellEnter(object sender, DataGridViewCellEventArgs e)
        {
            textBox1.Text = dataGridView1.CurrentRow.Cells[0].Value.ToString();
            textBox2.Text = dataGridView1.CurrentRow.Cells[1].Value.ToString();
        }

        private void button1_Click(object sender, EventArgs e)
        {

            string sorgu = "insert polikliniklerview(poliklinikAdi) values (@poliklinikAdi)";
            komut = new SqlCommand(sorgu, baglanti);
            komut.Parameters.AddWithValue("@poliklinikID", textBox1.Text);
            komut.Parameters.AddWithValue("@poliklinikAdi", textBox2.Text);
            baglanti.Open();
            komut.ExecuteNonQuery();
            MessageBox.Show("Başarıyla Eklendi");
            baglanti.Close();
            poliklinikBilgiGetir();
        }

        private void button2_Click(object sender, EventArgs e)
        {
            string sorgu = "delete from polikliniklerview where poliklinikID = @poliklinikID";
            komut = new SqlCommand(sorgu, baglanti);
            komut.Parameters.AddWithValue("@poliklinikID", Convert.ToInt32(textBox1.Text));
            baglanti.Open();
            komut.ExecuteNonQuery();
            MessageBox.Show("Başarıyla Silindi");
            baglanti.Close();
            poliklinikBilgiGetir();
        }

        private void dataGridView1_CellContentClick(object sender, DataGridViewCellEventArgs e)
        {

        }
    }
}
