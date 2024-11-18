document.addEventListener('DOMContentLoaded', (event) => {
    const breedTextElements = [
        document.getElementById('breed2'),
        document.getElementById('breed4'),
        document.getElementById('breed5'),
        document.getElementById('breed3'),
        document.getElementById('breed1')
    ];

    let currentIndex = 0;
    const intervalTime = 2690; // Interval time in milliseconds (3 seconds)

    function highlightBreed(index) {
        breedTextElements.forEach(element => element.classList.remove('glow'));
        breedTextElements[index].classList.add('glow');
    }

    function updateHighlight() {
        highlightBreed(currentIndex);
        currentIndex = (currentIndex + 1) % breedTextElements.length;
    }

    setInterval(updateHighlight, intervalTime);

    highlightBreed(currentIndex);
});
