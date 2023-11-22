import { Controller } from "@hotwired/stimulus"
import mapboxgl from 'mapbox-gl'

// Connects to data-controller="map"
export default class extends Controller {
  static values = {
    apiKey: String,
    marker: Object
  }

  connect() {
    if (this.markerValue) {
      console.log("Marker value", this.markerValue);
      mapboxgl.accessToken = this.apiKeyValue;
      this.map = new mapboxgl.Map({
        container: this.element,
        style: "mapbox://styles/mapbox/streets-v10"
      });
      this.#addMarkerToMap();
      this.#fitMapToMarker();
    } else {
      console.error("Marker value is not defined");
    }
  }

  #addMarkerToMap() {
    const marker = this.markerValue;
    const popup = new mapboxgl.Popup().setHTML(marker.info_window_html);

    const customMarker = document.createElement("div");
    customMarker.innerHTML = marker.marker_html;

    new mapboxgl.Marker(customMarker)
      .setLngLat([marker.lng, marker.lat])
      .setPopup(popup)
      .addTo(this.map);
  }

  #fitMapToMarker() {
    const bounds = new mapboxgl.LngLatBounds();
    bounds.extend([this.markerValue.lng, this.markerValue.lat]);
    this.map.fitBounds(bounds, { padding: 30, maxZoom: 15, duration: 0 });
  }
}
