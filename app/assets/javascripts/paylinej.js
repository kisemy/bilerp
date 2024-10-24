document.addEventListener('DOMContentLoaded', function() {
    const accountTypeSelect = document.getElementById('account_type_select');
    const customerSelect = document.getElementById('customer_select');
    const vendorSelect = document.getElementById('vendor_select');
    const bankSelect = document.getElementById('bank_select');

    // Function to show/hide dropdowns based on account type selection
    function updateDropdowns() {
      const accountType = accountTypeSelect.value;

      // Hide all dropdowns initially
      customerSelect.style.display = 'none';
      vendorSelect.style.display = 'none';
      bankSelect.style.display = 'none';

      // Show the appropriate dropdown based on the selected account type
      if (accountType === 'Customer') {
        customerSelect.style.display = 'block';
      } else if (accountType === 'Vendor') {
        vendorSelect.style.display = 'block';
      } else if (accountType === 'Bank') {
        bankSelect.style.display = 'block';
      }
    }

    // Initial call to hide/show dropdowns if needed
    updateDropdowns();

    // Event listener for when account_type is changed
    accountTypeSelect.addEventListener('change', updateDropdowns);
  });


