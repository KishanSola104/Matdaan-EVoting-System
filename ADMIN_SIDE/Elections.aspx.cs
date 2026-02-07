using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
using System.Data.SqlClient;


public partial class Elections : System.Web.UI.Page
{
    SqlConnection con = new SqlConnection(@"Data Source=.\SQLEXPRESS;AttachDbFilename=C:\Users\SOHAN SOLANKI\Desktop\Final_year_project\App_Data\Database2.mdf;Integrated Security=True;User Instance=True");
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            // Ensure the admin is logged in
            if (Session["AdminID"] == null)
            {
                Response.Redirect("admin_login.aspx");
            }

            // Get admin name and image URL from session and display them
            string adminName = Session["AdminName"] as string ?? "Admin";
            string adminImage = Session["AdminImage"] as string ?? "default.jpg";

            AdminName.InnerText = adminName;
            ProfilePic.Src = adminImage; // Assuming 'ProfilePic' is the image ID

            PopulateDateOfBirth();
            PopulateDateOfBirth1();
            PopulateStates();

            GridView1.Visible = false;
        }
    }

    private void PopulateDateOfBirth()
    {
        for (int day = 1; day <= 31; day++)
            ddlDay.Items.Add(new ListItem(day.ToString(), day.ToString()));


        string[] months = { "January", "February", "March", "April", "May", "June", "July", "August", "September", "October", "November", "December" };
        for (int i = 0; i < months.Length; i++)
            ddlMonth.Items.Add(new ListItem(months[i], (i + 1).ToString()));


        for (int year = 2020; year <= 2030; year++)
            ddlYear.Items.Add(new ListItem(year.ToString(), year.ToString()));
    }

    private void PopulateDateOfBirth1()
    {
        for (int day = 1; day <= 31; day++)
            ddlDay1.Items.Add(new ListItem(day.ToString(), day.ToString()));


        string[] months = { "January", "February", "March", "April", "May", "June", "July", "August", "September", "October", "November", "December" };
        for (int i = 0; i < months.Length; i++)
            ddlMonth1.Items.Add(new ListItem(months[i], (i + 1).ToString()));


        for (int year = 2020; year <= 2030; year++)
            ddlYear1.Items.Add(new ListItem(year.ToString(), year.ToString()));
    }

    private void PopulateStates()
    {
        List<string> states = new List<string> { "Andhra Pradesh", "Arunachal Pradesh", "Assam", "Bihar", "Chhattisgarh", "Goa", "Gujarat", "Haryana", "Himachal Pradesh", "Jammu and Kashmir", "Jharkhand", "Karnataka", "Kerala", "Madhya Pradesh", "Maharashtra", "Manipur", "Meghalaya", "Mizoram", "Nagaland", "Odisha", "Punjab", "Rajasthan", "Sikkim", "Tamil Nadu", "Telangana", "Tripura", "Uttar Pradesh", "Uttarakhand", "West Bengal" };
        ddlState.Items.Add(new ListItem("Select State", ""));
        foreach (string state in states)
            ddlState.Items.Add(new ListItem(state, state));

        ddlState.SelectedValue = "Select State"; // Default selection
    }

    protected void ddlState_SelectedIndexChanged(object sender, EventArgs e)
    {
        string selectedState = ddlState.SelectedValue;
        // PopulateDistricts(selectedState);
    }


    protected void btnSubmit1_Click(object sender, EventArgs e)
    {
        if (TextBox1.Text != "" && TextBox2.Text != "" && TextBox3.Text != "" && TextBox4.Text != "" && TextBox5.Text != "")
        {
            string connString = @"Data Source=.\SQLEXPRESS;AttachDbFilename=C:\Users\SOHAN SOLANKI\Desktop\Final_year_project\App_Data\Database2.mdf;Integrated Security=True;User Instance=True";

            string electionID = TextBox1.Text.Trim();
            string electionName = TextBox2.Text.Trim();
            string totalParties = TextBox3.Text.Trim();
            string totalCandidates = TextBox4.Text.Trim();
            string totalVoters = TextBox5.Text.Trim();
            string stateName = ddlState.SelectedItem != null ? ddlState.SelectedItem.Text : string.Empty;

            string dateOfElection = (ddlYear != null && ddlYear.SelectedValue != null ? ddlYear.SelectedValue : string.Empty) + "-" +
                              (ddlMonth != null && ddlMonth.SelectedValue != null ? ddlMonth.SelectedValue : string.Empty) + "-" +
                              (ddlDay != null && ddlDay.SelectedValue != null ? ddlDay.SelectedValue : string.Empty);

            string dateOfResult = (ddlYear1 != null && ddlYear1.SelectedValue != null ? ddlYear1.SelectedValue : string.Empty) + "-" +
                                  (ddlMonth1 != null && ddlMonth1.SelectedValue != null ? ddlMonth1.SelectedValue : string.Empty) + "-" +
                                  (ddlDay1 != null && ddlDay1.SelectedValue != null ? ddlDay1.SelectedValue : string.Empty);

            if (string.IsNullOrWhiteSpace(dateOfElection) || string.IsNullOrWhiteSpace(dateOfResult))
            {
                Response.Write("<script>alert('Please select valid dates.');</script>");
                return;
            }

            int parsedParties, parsedCandidates, parsedVoters;

            if (!int.TryParse(totalParties, out parsedParties) ||
                !int.TryParse(totalCandidates, out parsedCandidates) ||
                !int.TryParse(totalVoters, out parsedVoters))
            {
                Response.Write("<script>alert('Please enter valid numeric values for parties, candidates, and voters.');</script>");
                return;
            }


            string query = "INSERT INTO Election (ElectionID, ElectionName, StateName, TotalParties, TotalCandidates, TotalVoters, DateOfElection, DateOfResult) " +
                           "VALUES (@ElectionID, @ElectionName, @StateName, @TotalParties, @TotalCandidates, @TotalVoters, @DateOfElection, @DateOfResult)";

            try
            {
                using (SqlConnection conn = new SqlConnection(connString))
                {
                    conn.Open();
                    using (SqlCommand cmd = new SqlCommand(query, conn))
                    {
                        cmd.Parameters.Add(new SqlParameter("@ElectionID", SqlDbType.NVarChar) { Value = electionID });
                        cmd.Parameters.Add(new SqlParameter("@ElectionName", SqlDbType.NVarChar) { Value = electionName });
                        cmd.Parameters.Add(new SqlParameter("@StateName", SqlDbType.NVarChar) { Value = stateName });
                        cmd.Parameters.Add(new SqlParameter("@TotalParties", SqlDbType.Int) { Value = int.Parse(totalParties) });
                        cmd.Parameters.Add(new SqlParameter("@TotalCandidates", SqlDbType.Int) { Value = int.Parse(totalCandidates) });
                        cmd.Parameters.Add(new SqlParameter("@TotalVoters", SqlDbType.Int) { Value = int.Parse(totalVoters) });
                        cmd.Parameters.Add(new SqlParameter("@DateOfElection", SqlDbType.Date) { Value = DateTime.Parse(dateOfElection) });
                        cmd.Parameters.Add(new SqlParameter("@DateOfResult", SqlDbType.Date) { Value = DateTime.Parse(dateOfResult) });

                        int rowsAffected = cmd.ExecuteNonQuery();

                        if (rowsAffected > 0)
                        {
                            Response.Write("<script>alert('Election added successfully!');</script>");
                        }
                        else
                        {
                            Response.Write("<script>alert('No rows were added. Check the input data.');</script>");
                        }
                    }
                }


                // Reset the TextBoxes to their default empty value
                TextBox1.Text = string.Empty;  // Election ID
                TextBox2.Text = string.Empty;  // Election Name
                TextBox3.Text = string.Empty;  // Total No. of Parties
                TextBox4.Text = string.Empty;
                TextBox5.Text = string.Empty;

                // Reset the DropDownList for Election (if any options are selected)
                DropDownList1.SelectedIndex = -1;  // Reset DropDownList (No selection)

                // Reset the State DropDownList
                ddlState.SelectedIndex = -1;  // Reset the State selection

                // Reset the Date fields to their default value (e.g., first option or blank)
                ddlDay.SelectedIndex = -1;    // Reset Day dropdown
                ddlMonth.SelectedIndex = -1;  // Reset Month dropdown
                ddlYear.SelectedIndex = -1;   // Reset Year dropdown

                // Reset the Date of Results fields to their default value (e.g., first option or blank)
                ddlDay1.SelectedIndex = -1;   // Reset Day dropdown
                ddlMonth1.SelectedIndex = -1; // Reset Month dropdown
                ddlYear1.SelectedIndex = -1;  // Reset Year dropdown
            }
            catch (Exception ex)
            {
                Response.Write("<script>alert('Error: " + ex.Message + "');</script>");
            }

            DropDownList1.DataBind();
           GridView1.DataBind();
      
        }
        else
        {
            Response.Write("<script>alert('Please Fill All The Fields Check the input data.');</script>");
        }
    }
    protected void btnSubmit2_Click(object sender, EventArgs e)
    {
        GridView1.Visible = true;
       
    }

  


    protected void btnSubmit3_Click(object sender, EventArgs e)
    {
        // Reset the TextBoxes to their default empty value
        TextBox1.Text = string.Empty;  // Election ID
        TextBox2.Text = string.Empty;  // Election Name
        TextBox3.Text = string.Empty;  // Total No. of Parties
        TextBox4.Text = string.Empty;
        TextBox5.Text = string.Empty;

        // Reset the DropDownList for Election (if any options are selected)
        DropDownList1.SelectedIndex = -1;  // Reset DropDownList (No selection)

        // Reset the State DropDownList
        ddlState.SelectedIndex = -1;  // Reset the State selection

        // Reset the Date fields to their default value (e.g., first option or blank)
        ddlDay.SelectedIndex = -1;    // Reset Day dropdown
        ddlMonth.SelectedIndex = -1;  // Reset Month dropdown
        ddlYear.SelectedIndex = -1;   // Reset Year dropdown

        // Reset the Date of Results fields to their default value (e.g., first option or blank)
        ddlDay1.SelectedIndex = -1;   // Reset Day dropdown
        ddlMonth1.SelectedIndex = -1; // Reset Month dropdown
        ddlYear1.SelectedIndex = -1;  // Reset Year dropdown

        // Hide the GridView when cancel is clicked
        GridView1.Visible = false;
    }
    protected void btnSubmit4_Click(object sender, EventArgs e)
    {
        if (TextBox1.Text != "")
        {
            // Direct connection string
            string connString = @"Data Source=.\SQLEXPRESS;AttachDbFilename=C:\Users\SOHAN SOLANKI\Desktop\Final_year_project\App_Data\Database2.mdf;Integrated Security=True;User Instance=True";

            // Get values from the form
            string electionID = TextBox1.Text.Trim();
            string electionName = TextBox2.Text.Trim();
            string totalParties = TextBox3.Text.Trim();
            string totalCandidates = TextBox4.Text.Trim();
            string totalVoters = TextBox5.Text.Trim();
            string stateName = ddlState.SelectedItem != null ? ddlState.SelectedItem.Text : string.Empty; // Selected State

            // Date handling - get values from Day, Month, and Year dropdowns for Election Date
            string dateOfElection = ddlYear.SelectedValue + "-" + ddlMonth.SelectedValue + "-" + ddlDay.SelectedValue;

            // Date handling - get values from Day, Month, and Year dropdowns for Result Date
            string dateOfResult = ddlYear1.SelectedValue + "-" + ddlMonth1.SelectedValue + "-" + ddlDay1.SelectedValue;

            // Debugging: Check if values are being captured correctly
           // Response.Write("<script>alert('ElectionID: " + electionID + " ElectionName: " + electionName + " TotalParties: " + totalParties + " StateName: " + stateName + " TotalCandidates: " + totalCandidates + " TotalVoters: " + totalVoters + " DateOfElection: " + dateOfElection + " DateOfResult: " + dateOfResult + "');</script>");

            // SQL query to insert data into the Elections table
            string query = "UPDATE Election SET  ElectionName=@ElectionName , TotalParties=@TotalParties, StateName=@StateName, TotalCandidates=@TotalCandidates , TotalVoters=@TotalVoters ,DateOfElection=@DateOfElection, DateOfResult=@DateOfResult WHERE ElectionID=@ElectionID";

            try
            {
                // Open connection and execute query
                using (SqlConnection conn = new SqlConnection(connString))
                {
                    conn.Open();
                    using (SqlCommand cmd = new SqlCommand(query, conn))
                    {
                        // Add parameters to SQL command to prevent SQL injection
                        cmd.Parameters.AddWithValue("@ElectionID", electionID);
                        cmd.Parameters.AddWithValue("@ElectionName", electionName);
                        cmd.Parameters.AddWithValue("@StateName", stateName);
                        cmd.Parameters.AddWithValue("@TotalParties", totalParties);
                        cmd.Parameters.AddWithValue("@TotalCandidates", totalCandidates);
                        cmd.Parameters.AddWithValue("@TotalVoters", totalVoters);
                        cmd.Parameters.AddWithValue("@DateOfElection", dateOfElection);
                        cmd.Parameters.AddWithValue("@DateOfResult", dateOfResult);


                        // Execute the query and check for successful insertion
                        int rowsAffected = cmd.ExecuteNonQuery();

                        if (rowsAffected > 0)
                        {
                            Response.Write("<script>alert('Election Updated successfully!');</script>");
                        }
                        else
                        {
                            Response.Write("<script>alert('No rows were Updated. Check the input data.');</script>");
                        }
                    }
                }


                // Reset the TextBoxes to their default empty value
                TextBox1.Text = string.Empty;  // Election ID
                TextBox2.Text = string.Empty;  // Election Name
                TextBox3.Text = string.Empty;  // Total No. of Parties
                TextBox4.Text = string.Empty;
                TextBox5.Text = string.Empty;

                // Reset the DropDownList for Election (if any options are selected)
                DropDownList1.SelectedIndex = -1;  // Reset DropDownList (No selection)

                // Reset the State DropDownList
                ddlState.SelectedIndex = -1;  // Reset the State selection

                // Reset the Date fields to their default value (e.g., first option or blank)
                ddlDay.SelectedIndex = -1;    // Reset Day dropdown
                ddlMonth.SelectedIndex = -1;  // Reset Month dropdown
                ddlYear.SelectedIndex = -1;   // Reset Year dropdown

                // Reset the Date of Results fields to their default value (e.g., first option or blank)
                ddlDay1.SelectedIndex = -1;   // Reset Day dropdown
                ddlMonth1.SelectedIndex = -1; // Reset Month dropdown
                ddlYear1.SelectedIndex = -1;  // Reset Year dropdown
            }
            catch (Exception ex)
            {
                // Handle any errors that occur during the insertion
                Response.Write("<script>alert('Error: " + ex.Message + "');</script>");
            }

            DropDownList1.DataBind();
            GridView1.DataBind();
          
        }
        else
        {
            Response.Write("<script>alert('Please Fill The ID Of Election To Update.');</script>");
        }

    }
    protected void btnSubmit5_Click(object sender, EventArgs e)
    {
        if (TextBox1.Text != "")
        {
            // Direct connection string
            string connString = @"Data Source=.\SQLEXPRESS;AttachDbFilename=C:\Users\SOHAN SOLANKI\Desktop\Final_year_project\App_Data\Database2.mdf;Integrated Security=True;User Instance=True";

            // Get values from the form
            string electionID = TextBox1.Text.Trim();

            // SQL query to insert data into the Elections table
            string query = "DELETE FROM Election WHERE ElectionID=@ElectionID";

            try
            {
                // Open connection and execute query
                using (SqlConnection conn = new SqlConnection(connString))
                {
                    conn.Open();
                    using (SqlCommand cmd = new SqlCommand(query, conn))
                    {
                        // Add parameters to SQL command to prevent SQL injection
                        cmd.Parameters.AddWithValue("@ElectionID", electionID);

                        // Execute the query and check for successful insertion
                        int rowsAffected = cmd.ExecuteNonQuery();

                        if (rowsAffected > 0)
                        {
                            Response.Write("<script>alert('Election Deleted successfully!');</script>");
                        }
                        else
                        {
                            Response.Write("<script>alert('No rows were Deleted. Check the input data.');</script>");
                        }
                    }
                }


                // Reset the TextBoxes to their default empty value
                TextBox1.Text = string.Empty;  // Election ID
                TextBox2.Text = string.Empty;  // Election Name
                TextBox3.Text = string.Empty;  // Total No. of Parties
                TextBox4.Text = string.Empty;
                TextBox5.Text = string.Empty;

                // Reset the DropDownList for Election (if any options are selected)
                DropDownList1.SelectedIndex = -1;  // Reset DropDownList (No selection)

                // Reset the State DropDownList
                ddlState.SelectedIndex = -1;  // Reset the State selection

                // Reset the Date fields to their default value (e.g., first option or blank)
                ddlDay.SelectedIndex = -1;    // Reset Day dropdown
                ddlMonth.SelectedIndex = -1;  // Reset Month dropdown
                ddlYear.SelectedIndex = -1;   // Reset Year dropdown

                // Reset the Date of Results fields to their default value (e.g., first option or blank)
                ddlDay1.SelectedIndex = -1;   // Reset Day dropdown
                ddlMonth1.SelectedIndex = -1; // Reset Month dropdown
                ddlYear1.SelectedIndex = -1;  // Reset Year dropdown
            }
            catch (Exception ex)
            {
                // Handle any errors that occur during the insertion
                Response.Write("<script>alert('Error: " + ex.Message + "');</script>");
            }

            DropDownList1.DataBind();
            GridView1.DataBind();
          
        }
        else
        {
            Response.Write("<script>alert('Please Fill The ID Of The Election to Delete.');</script>");
        }

    }
    protected void DropDownList1_SelectedIndexChanged(object sender, EventArgs e)
    {
        try
        {
            con.Open();
            string q1 = "select * from Election where ElectionID = '" + DropDownList1.Text + "'";

            SqlCommand cmd = new SqlCommand(q1, con);
            SqlDataReader sdr = cmd.ExecuteReader();

            while (sdr.Read())
            {
                // Populating textboxes
                TextBox1.Text = sdr["ElectionID"].ToString();
                TextBox2.Text = sdr["ElectionName"].ToString();
                ddlState.Text = sdr["StateName"].ToString();
                TextBox3.Text = sdr["TotalParties"].ToString();
                TextBox4.Text = sdr["TotalCandidates"].ToString();
                TextBox5.Text = sdr["TotalVoters"].ToString();

                // Populating Date of Election
                DateTime electionDate = Convert.ToDateTime(sdr["DateOfElection"]);  // Assuming ElectionDate is stored as a DateTime
                ddlDay.SelectedValue = electionDate.Day.ToString();
                ddlMonth.SelectedValue = electionDate.Month.ToString();
                ddlYear.SelectedValue = electionDate.Year.ToString();

                // Populating Date of Results
                DateTime resultDate = Convert.ToDateTime(sdr["DateOfResult"]);  // Assuming ResultDate is stored as a DateTime
                ddlDay1.SelectedValue = resultDate.Day.ToString();
                ddlMonth1.SelectedValue = resultDate.Month.ToString();
                ddlYear1.SelectedValue = resultDate.Year.ToString();
            }
        }
        catch (SqlException ex)
        {
            Label1.Text = "Exception is " + ex.Message;
            Label1.ForeColor = System.Drawing.Color.Red;
        }
    }


    protected void TextBox3_TextChanged(object sender, EventArgs e)
    {

    }
}