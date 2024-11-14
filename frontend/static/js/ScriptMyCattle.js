function add_cow() {
    // Get data from the form inputs
    const cowData = {
      name: document.getElementById("name").value,
      age: document.getElementById("age").value,
      breed: document.getElementById("breed").value,
      weight: document.getElementById("weight").value
    };
  
    // Send an AJAX request using fetch
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

        // Create a new cow information block
        const newCowHTML = `
          <div class="cow-info">
            <h2>Added Cow:</h2>
            <p>ID: ${data.id}</p>
            <p>Name: ${data.name}</p>
            <p>Age: ${data.age}</p>
            <p>Weight: ${data.weight}</p>
          </div>
        `;
      
        // Append the new cow info to the existing content
        cowDisplay.innerHTML += newCowHTML;
        

      document.getElementById("cowForm").reset();
    })
    .catch(error => console.error('Error:', error));
  }



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




