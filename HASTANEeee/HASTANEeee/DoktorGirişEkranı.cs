using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Data.Common;
using System.Data.SqlClient;
using System.Drawing;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows.Forms;
using static System.Windows.Forms.VisualStyles.VisualStyleElement;

namespace HASTANEeee
{
    public partial class DoktorGirişEkranı : Form
    {
        public DoktorGirişEkranı()
        {
            InitializeComponent();
        }

        SqlConnection baglanti;
        SqlDataAdapter da;
        DataTable dt;
        void RandevuBilgileriGetir()
        {
            baglanti = new SqlConnection("Data Source=DESKTOP-0M417A5;Initial Catalog=hastane;Integrated Security=True");
            baglanti.Open();
            da = new SqlDataAdapter("SELECT * from AalınanRandevular ", baglanti);
            DataTable tablo = new DataTable();
            da.Fill(tablo);
            dataGridView1.DataSource = tablo;
            baglanti.Close();
        }
        

        private void button3_Click(object sender, EventArgs e)
        {
            formlar.formDoktorGirişi.Show();
            this.Hide();
        }

        private void DoktorGirişEkranı_Load(object sender, EventArgs e)
        {
            RandevuBilgileriGetir();
        }

        private void dataGridView1_CellContentClick(object sender, DataGridViewCellEventArgs e)
        {

        }

        private void button1_Click(object sender, EventArgs e) //ARA
        {
            baglanti.Open();
            SqlCommand command = new SqlCommand("select * from dbo.DoktorRandevulari(@doktorID);", baglanti);            
            command.Parameters.AddWithValue("@doktorID", textBox1.Text);
            da = new SqlDataAdapter(command);
            dt = new DataTable();
            da.Fill(dt);

            dataGridView1.DataSource = dt;
            baglanti.Close();


        }

        private void textBox1_TextChanged(object sender, EventArgs e)
        {

        }
    }
}
