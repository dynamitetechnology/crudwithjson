<%@ Page Title="Home Page" Language="C#"  AutoEventWireup="true" CodeBehind="Default.aspx.cs" Inherits="CrudUsingAjax._Default" %>

<!doctype html>
<html lang="en">
  <head>
    <!-- Required meta tags -->
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">

    <!-- Bootstrap CSS -->
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.6.1/dist/css/bootstrap.min.css" integrity="sha384-zCbKRCUGaJDkqS1kPbPd7TveP5iyJE0EjAuZQTgFLD2ylzuqKfdKlfG/eSrtxUkn" crossorigin="anonymous">

    <title>Hello, world!</title>
  </head>
  <body>
    <h1>Hello, world!</h1>

<div class="container">
    <div class="row">
    <div class="col-md-4">    
  <div class="form-group">
    <label for="exampleInputEmail1">Name</label>
    <input type="text" class="form-control" id="name" >
  </div>
  <div class="form-group">
    <label for="exampleInputPassword1">Email</label>
    <input type="text" class="form-control" id="email">
  </div>

          <div class="form-group">
    <label for="exampleInputPassword1">Phone</label>
    <input type="text" class="form-control" id="phone">
  </div>
  <button type="button" class="btn btn-primary savecontacts">Submit</button>
    </div>

        <div class="col-md-6">
            <div class="contactTable"></div>
        </div>
</div>
</div>


   <script src="https://code.jquery.com/jquery-3.6.0.js" integrity="sha256-H+K7U5CnXl1h5ywQfKtSj8PCmoN9aaq30gDh27Xc0jk=" crossorigin="anonymous"></script>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@4.6.1/dist/js/bootstrap.bundle.min.js" integrity="sha384-fQybjgWLrvvRgtW6bFlB7jaZrFsaBXjsOMm/tB9LTS58ONXgqbR9W8oWht/amnpF" crossorigin="anonymous"></script>

      <script>
          $(document).ready(function () {
              displaycontacts()
              $(".savecontacts").on('click', function () {
                  let name = $("#name").val()
                  let email = $("#email").val()
                  let phone  = $("#phone").val()
                  console.log('Hello', name, email, phone)
                  let datastring = { name: name, email: email, phone: phone }

                  $.ajax({
                      type: "POST",
                      url: "Default.aspx/savecontacts",
                      data: JSON.stringify(datastring),
                      contentType:"application/json; charset=utf-8",
                      success: function (resp) {
                          $("#name").val("")
                          $("#email").val("")
                          $("#phone").val("")
                          displaycontacts()
                      },
                      dataType: "json"
                  });
              })
          })


          function displaycontacts() {
              $.ajax({
                  type: "POST",
                  url: "Default.aspx/displaycontacts",
                  data: {},
                  contentType: "application/json; charset=utf-8",
                  success: function (resp) {


                      let table = `<table class="table">
<tr>
<th>id</th>
<th>Name</th>
<th>Email</th>
<th>Phone</th>
</tr>
`;

                      let response = JSON.parse(resp.d);

                      response.forEach(function (item) {
                          console.log(item)

                          table += `<tr>
<td>${item.id}</td>
<td>${item.name}</td>
<td>${item.email}</td>
<td>${item.phone}</td>
</tr>`;

                      })




                      table += `</table>`

                      console.log(table)
                      $(".contactTable").html(table)
                  },
                  dataType: "json"
              });
          }


      </script>

  </body>
</html>