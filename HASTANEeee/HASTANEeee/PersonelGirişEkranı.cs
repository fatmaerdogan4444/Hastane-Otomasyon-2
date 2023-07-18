using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows.Forms;

namespace HASTANEeee
{
    public partial class PersonelGirişEkranı : Form
    {
        public PersonelGirişEkranı()
        {
            InitializeComponent();
        }

        private void button3_Click(object sender, EventArgs e) //Geri
        {
            formlar.formPersonelGirişi.Show();
            this.Hide();
        }

        private void button1_Click(object sender, EventArgs e)
        {
            formlar.formDoktorEkle.Show();
            this.Hide();
        }

        private void button2_Click(object sender, EventArgs e)
        {
            formlar.formPoliklinikEkle.Show();
            this.Hide();
        }

        private void PersonelGirişEkranı_Load(object sender, EventArgs e)
        {

        }
    }
}
