import { Controller } from "@hotwired/stimulus";

// Connects to data-controller="cart"
export default class extends Controller {
  initialize() {
    const cart = JSON.parse(localStorage.getItem("cart"));
    let total = 0;
    if (!cart) {
      return;
    } else {
      for (let i = 0; i < cart.length; i++) {
        total += cart[i].price * cart[i].quantity;
        const div = document.createElement("div");
        div.classList.add("mt-2");
        div.innerHTML = `Item: ${cart[i].name} - $${
          cart[i].price / 100.0
        } - Size: ${cart[i].size} - Quantity: ${cart[i].quantity}`;
        const deleteButton = document.createElement("button");
        deleteButton.innerText = "Remove";
        deleteButton.value = JSON.stringify({
          id: cart[i].id,
          size: cart[i].size,
        });
        deleteButton.classList.add(
          "bg-gray-500",
          "rounded",
          "text-white",
          "px-2",
          "py-1",
          "ml-2"
        );
        deleteButton.addEventListener("click", this.removeFromCart);
        div.appendChild(deleteButton);
        this.element.prepend(div);
      }
    }
    const totalEl = document.createElement("div");
    totalEl.innerText = `Total: $${total / 100.0}`;
    let totalContainer = document.querySelector("#total");
    totalContainer.appendChild(totalEl);
  }

  removeFromCart(event) {
    const cart = JSON.parse(localStorage.getItem("cart"));
    const { id, size } = JSON.parse(event.target.value);
    const index = cart.findIndex(
      (item) => item.id === id && item.size === size
    );
    // const newCart = cart.filter((item) => item.id !== id);
    cart.splice(index, 1);
    localStorage.setItem("cart", JSON.stringify(cart));
    window.location.reload();
  }

  clear() {
    localStorage.removeItem("cart");
    window.location.reload();
  }

  checkout() {
    const cart = JSON.parse(localStorage.getItem("cart"));
    const payload = {
      authenticity_token: "",
      cart: cart,
    };
    const csrfToken = document.querySelector("[name='csrf-token']").content;
    fetch("/checkout", {
      method: "POST",
      headers: {
        "Content-Type": "application/json",
        "X-CSRF-Token": csrfToken,
      },
      body: JSON.stringify(payload),
    }).then((response) => {
      if (response.ok) {
        response.json().then((body) => {
          window.location.href = body.url;
        });
      } else {
        response.json().then((body) => {
          const errorEl = document.createElement("div");
          errorEl.innerText = `There was an error processing your order checkout: ${body.error}`;
          let errorContainer = document.querySelector("#errorContainer");
          errorContainer.appendChild(errorEl);
        });
      }
    });
  }
}
