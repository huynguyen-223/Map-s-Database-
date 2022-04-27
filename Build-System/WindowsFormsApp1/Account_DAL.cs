using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Data;
using System.Data.SqlClient;

namespace DAL_QuanLyXeBuyt
{
    class Account_DAL
    {
        private static Account_DAL instance;

        public static Account_DAL Instance
        {
            get { if (instance == null) instance = new Account_DAL(); return instance; }
            private set { instance = value; }
        }

        private Account_DAL() { }

        public bool Login(string userName, string passWord)
        {
            string query = "EXEC SELECT_ACCOUNT '" + userName + "','" + passWord + "'";
            DataTable result = DataProvider.Instance.ExecuteQuery(query);
            return result.Rows.Count > 0;
        }
    }
}
