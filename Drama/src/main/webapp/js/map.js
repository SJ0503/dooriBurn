document.addEventListener("DOMContentLoaded", function() {
    if (typeof kakao !== 'undefined' && kakao.maps) {
        kakao.maps.load(function() {
            initializeMap();
        });
    } else {
        console.error("Kakao maps API is not loaded.");
    }
});

function initializeMap() {
    var mapContainer = document.getElementById('map'); // 지도를 표시할 div
    if (mapContainer) {
        var lat = parseFloat(mapContainer.getAttribute('data-lat'));
        var lon = parseFloat(mapContainer.getAttribute('data-lon'));

        if (isNaN(lat) || isNaN(lon)) {
            console.error("Invalid latitude or longitude values.");
            return;
        }

        var mapOption = {
            center: new kakao.maps.LatLng(lat, lon),
            level: 3
        };

        var map = new kakao.maps.Map(mapContainer, mapOption);

        var markerPosition = new kakao.maps.LatLng(lat, lon);
        var marker = new kakao.maps.Marker({
            position: markerPosition
        });

        marker.setMap(map);
    } else {
    }
}

// 검색 결과에 따라 지도를 업데이트하는 함수
function displayResults(results) {
    var mapContainer = document.getElementById('map');
    
    if (mapContainer && results.length > 0) {
        var mapOption = {
            center: new kakao.maps.LatLng(results[0].위도, results[0].경도),
            level: 3
        };
        var map = new kakao.maps.Map(mapContainer, mapOption);
        
        results.forEach(result => {
            var markerPosition = new kakao.maps.LatLng(result.위도, result.경도);
            var marker = new kakao.maps.Marker({
                position: markerPosition
            });
            marker.setMap(map);
        });
    }
}
