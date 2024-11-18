

let menu = document.querySelector('#menu-icon');
let navlist = document.querySelector('.navlist');

menu.onclick = () => {
    menu.classList.toggle('bx-x');
    navlist.classList.toggle('open');
};

const sr = ScrollReveal ({
    distance: '65px',
    duration: 2600,
    delay: 450,
    reset: true
});

sr.reveal('.model-text', {delay:200, origin: 'top'});
sr.reveal('.model-img', {delay:450, origin: 'top'});
sr.reveal('.icons', {delay:500, origin: 'left'});
sr.reveal('.scroll-down', {delay:500, origin: 'right'});

/*

function add_cow() {
   
    const cowData = {
      name: document.getElementById("name").value,
      age: document.getElementById("age").value,
      breed: document.getElementById("breed").value,
      weight: document.getElementById("weight").value
    };
  
    fetch('/add_cow', {
      method: 'POST',
      headers: {
        'Content-Type': 'application/json'
      },
      body: JSON.stringify(cowData)
    })
    .then(response => response.json())
    .then(data => {
      
        const cowDisplay = document.getElementById("cowDisplay");

        
        const newCowHTML = `
          
        <button class="cow-info-button">
        <div class="cow-info">
            <h2>Added Cow:</h2>
            <p>ID: ${data.id}</p>
            <p>Name: ${data.name}</p>
            <p>Age: ${data.age}</p>
            <p>Weight: ${data.weight}</p>
        </div>
        </button>
     
        `;
      
        cowDisplay.innerHTML += newCowHTML;
        

      document.getElementById("cowForm").reset();
    })
    .catch(error => console.error('Error:', error));
}

*/

async function addCow() {
   
    const inputData = {
      name: document.getElementById("name").value,
      age: document.getElementById("age").value,
      breed: document.getElementById("breed").value,
      weight: document.getElementById("weight").value
    };

    try{
  
    let promesa = await fetch('/add_cow', {
      method: 'POST',
      headers: {
        'Content-Type': 'application/json'
      },
      body: JSON.stringify(inputData)
    })

    console.log(promesa)

    let cow_data = await promesa.json()
    console.log("Add_Cow AJAX")
 
    console.log(cow_data)

    const cowDisplay = document.getElementById('addCowDisplay')

    const newCowDisplay =  ` 
    
        <button class="cow-info-button">
        <div class="cow-info">
            <h2>Added Cow:</h2>
            <p>ID: ${cow_data[0].CowID}</p>
            <p>Name: ${cow_data[0].CowName}</p>
            <p>Breed: ${cow_data[0].Breed}</p>
            <p>Age: ${cow_data[0].Age}</p>
            <p>Weight: ${cow_data[0].Weight}</p>
        </div>
        </button>
     
    `;

    updateContador()
    
    cowDisplay.innerHTML += newCowDisplay
    
    }
    catch(error){
      console.log(error)
    }
    
}


async function updateContador() {
  let contadorElement = document.getElementById("contador")
  let contadorInt = parseInt(contadorElement.innerText)

  contadorInt += 1

  contadorElement.innerText = contadorInt  
}
//funcion adaptada
//input: De donde consigue la informacion de busqueda
//Output: Donde se muestra el re

async function searchCow(input,output){
  let cowId = {
    cowId : document.getElementById(input).value
  }
 

  try{
  let promesa = await fetch( '/search_cow' ,{

    method : 'POST',
    headers : {
      'Content-Type' : 'application/json'
    },
    body: JSON.stringify(cowId)
  })

  let cowInfo = await promesa.json()


  if(cowInfo){
  //checar si returnea vacio
  displaySearchedCow(cowInfo)

  return cowInfo
  }
  else{
    document.getElementById(output).innerHTML = '<h2>Invalid ID</h2>'
  }
}
catch(error){
  console.log(error)
}
}

async function displaySearchedCow(cowInfo){

  const showSearch = document.getElementById('showSearch').innerHTML

  let showCow = 
    ` <div class="search-cow">
            <h2>${cowInfo.CowId}</h2>
            <p>ID: ${cowInfo[0].CowID}</p>
            <p>Name: ${cowInfo[0].CowName}</p>
            <p>Breed: ${cowInfo[0].Breed}</p>
            <p>Age: ${cowInfo[0].Age}</p>
            <p>Weight: ${cowInfo[0].Weight}</p>
            <p>Date Added: ${cowInfo[0].Date}</p> //checar esta parte
        </div> `;

  
  showSearch = showCow

}

async function cowTransfer(){

  try{
  
  if (searchCow('cowTransfer','showAvailableRanches')){

  }

  }
  catch(error){
    console.log(error)
  }
}




