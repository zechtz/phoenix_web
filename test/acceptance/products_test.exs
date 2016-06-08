defmodule PheonixCommerce.Acceptance.ProductsTest do
  use ExUnit.Case
  use Hound.Helpers
  hound_session

  alias PheonixCommerce.Product
  alias PheonixCommerce.Repo 

  setup do
    Repo.delete_all(Product)
    {:ok, product} = 
    %Product{name: "Some Product", 
      description: "Some product description", 
      price: Decimal.new("25.20")
    } |> Repo.insert 
    {:ok, product: product} 
  end 

  test "/products has a list of products" do
    navigate_to "/products"
    assert find_element(:css, "ul.products")
  end 

  test "/products - product details include name, description and price",
    %{product: product} do 
    navigate_to "/products"

    product_li  = find_element(:css, "ul.products li")
    name        = find_within_element(product_li, :css, "h3")
    price       = find_within_element(product_li, :css, "h4")
    description = find_within_element(product_li, :css, "p")

    assert visible_text(name)        == product.name
    assert visible_text(price)       == "$#{product.price}"
    assert visible_text(description) == product.description
  end 

  test "/products clickiing a product will open product details", %{product: product} do
    navigate_to "/products"
    product_li  = find_element(:css, "ul.products li")
    link = find_within_element(product_li, :css, "a")
    click(link)
    assert "/products/#{product.id}" == current_path 
  end
end 
