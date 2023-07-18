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
using static System.Windows.Forms.VisualStyles.VisualStyleElement;

namespace HASTANEeee
{
    public partial class RandevuAl : Form
    {
        public RandevuAl()
        {
            InitializeComponent();
        }
        SqlConnection baglanti;
        SqlCommand komut;
        SqlConnection baglanti2 = new SqlConnection("Data Source=DESKTOP-0M417A5;Initial Catalog=hastane;Integrated Security=True");
        SqlDataAdapter da;

        void RandevuBilgiGetir()
        {
            baglanti = new SqlConnection("Data Source=DESKTOP-0M417A5;Initial Catalog=hastane;Integrated Security=True");
            baglanti.Open();
            da = new SqlDataAdapter("SELECT * from AalınanRandevular;", baglanti);
            DataTable tablo = new DataTable();
            da.Fill(tablo);
            dataGridView1.DataSource = tablo;
            baglanti.Close();
        }

        private void comboBox1_SelectedIndexChanged(object sender, EventArgs e)
        {

        }

        private void RandevuAl_Load(object sender, EventArgs e)
        {
            // TODO: Bu kod satırı 'hastaneDataSetBuSon.ddoktorlar' tablosuna veri yükler. Bunu gerektiği şekilde taşıyabilir, veya kaldırabilirsiniz.
            this.ddoktorlarTableAdapter.Fill(this.hastaneDataSetBuSon.ddoktorlar);
            // TODO: Bu kod satırı 'hastaneDataSetBuSon.poliklinikler' tablosuna veri yükler. Bunu gerektiği şekilde taşıyabilir, veya kaldırabilirsiniz.
            this.polikliniklerTableAdapter1.Fill(this.hastaneDataSetBuSon.poliklinikler);
            // TODO: Bu kod satırı 'hastaneDataSet.poliklinikler' tablosuna veri yükler. Bunu gerektiği şekilde taşıyabilir, veya kaldırabilirsiniz.
            this.polikliniklerTableAdapter.Fill(this.hastaneDataSet.poliklinikler);
            RandevuBilgiGetir();
        }

        private void button3_Click(object sender, EventArgs e)
        {
            formlar.formHastaGirişi.Show();
            this.Hide();
        }

        private void button1_Click(object sender, EventArgs e)
        {
            string sorgu = "insert AalınanRandevular(TC,poliklinikAdi,DoktorAdi,Tarih,Saat)  values(@TC,@poliklinikAdi,@DoktorAdi,@Tarih,@Saat)";
            komut = new SqlCommand(sorgu, baglanti);
            komut.Parameters.AddWithValue("@TC", Convert.ToString(textBox2.Text));

            komut.Parameters.AddWithValue("PoliklinikAdi", comboBox1.Text);
            komut.Parameters.AddWithValue("@DoktorAdi",comboBox2.Text );
            komut.Parameters.AddWithValue("@Tarih", dateTimePicker1.Text);
            komut.Parameters.AddWithValue("@Saat", comboBox3.Text);
            baglanti.Open();
            komut.ExecuteNonQuery();
            MessageBox.Show("Başarıyla Eklendi");
            baglanti.Close();
            RandevuBilgiGetir();
;            
        }

        private void textBox2_TextChanged(object sender, EventArgs e)
        {

        }

        private void comboBox2_SelectedIndexChanged(object sender, EventArgs e)
        {

        }

        private void dateTimePicker1_ValueChanged(object sender, EventArgs e)
        {

        }

        private void comboBox3_SelectedIndexChanged(object sender, EventArgs e)
        {

        }

        private void button2_Click(object sender, EventArgs e) //randevu iptal
        {

            string sorgu = "delete from AalınanRandevular where randevuID = @RandevuID";
            komut = new SqlCommand(sorgu, baglanti);
            komut.Parameters.AddWithValue("@RandevuID", Convert.ToInt32(textBox1.Text));
            baglanti.Open();
            komut.ExecuteNonQuery();
            MessageBox.Show("Başarıyla Silindi");
            baglanti.Close();
            RandevuBilgiGetir();

            /* delete from AalınanRandevular where randevuID = 11
                                        select * from AalınanRandevular*/
        }

        private void dataGridView1_CellEnter(object sender, DataGridViewCellEventArgs e)
        {
            textBox1.Text = dataGridView1.CurrentRow.Cells[0].Value.ToString();
        }

        private void textBox1_TextChanged(object sender, EventArgs e)
        {

        }

        private void dataGridView1_CellContentClick(object sender, DataGridViewCellEventArgs e)
        {

        }
    }
}
