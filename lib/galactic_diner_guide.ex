defmodule GalacticDinerGuide do
  @moduledoc """
  GalacticDinerGuide keeps the contexts that define your domain
  and business logic.

  Contexts are also responsible for managing your data, regardless
  if it comes from the database, an external API or others.
  """
  alias GalacticDinerGuide.Parsers.SaveAllData
  alias GalacticDinerGuide.Customers.Actions.Create, as: CreateCustomer
  alias GalacticDinerGuide.Customers.Actions.Delete, as: DeleteCustomer
  alias GalacticDinerGuide.Customers.Actions.Get, as: GetCustomer
  alias GalacticDinerGuide.Customers.Actions.Undelete, as: UndeleteCustomer
  alias GalacticDinerGuide.Customers.Actions.Update, as: UpdateCustomer
  alias GalacticDinerGuide.Restaurants.Actions.Create, as: CreateRestaurant
  alias GalacticDinerGuide.Restaurants.Actions.Delete, as: DeleteRestaurant
  alias GalacticDinerGuide.Restaurants.Actions.Get, as: GetRestaurant
  alias GalacticDinerGuide.Restaurants.Actions.Undelete, as: UndeleteRestaurant
  alias GalacticDinerGuide.Restaurants.Actions.Update, as: UpdateRestaurant
  alias GalacticDinerGuide.RestaurantCustomers.Actions.Create, as: CreateRestaurantCustomer
  alias GalacticDinerGuide.RestaurantCustomers.Actions.Delete, as: DeleteRestaurantCustomer
  alias GalacticDinerGuide.RestaurantCustomers.Actions.Get, as: GetRestaurantCustomer
  alias GalacticDinerGuide.RestaurantCustomers.Actions.Undelete, as: UndeleteRestaurantCustomer
  alias GalacticDinerGuide.RestaurantCustomers.Actions.Update, as: UpdateRestaurantCustomer
  alias GalacticDinerGuide.Items.Actions.Create, as: CreateItem
  alias GalacticDinerGuide.Items.Actions.Delete, as: DeleteItem
  alias GalacticDinerGuide.Items.Actions.Get, as: GetItem
  alias GalacticDinerGuide.Items.Actions.Undelete, as: UndeleteItem
  alias GalacticDinerGuide.Items.Actions.Update, as: UpdateItem

  defdelegate save_data(filename), to: SaveAllData, as: :call
  defdelegate create_customer(params), to: CreateCustomer, as: :call
  defdelegate delete_customer(id), to: DeleteCustomer, as: :call
  defdelegate get_customer(id), to: GetCustomer, as: :call
  defdelegate undelete_customer(id), to: UndeleteCustomer, as: :call
  defdelegate update_customer(id, params), to: UpdateCustomer, as: :call
  defdelegate create_restaurant(params), to: CreateRestaurant, as: :call
  defdelegate delete_restaurant(id), to: DeleteRestaurant, as: :call
  defdelegate get_restaurant(id), to: GetRestaurant, as: :call
  defdelegate undelete_restaurant(id), to: UndeleteRestaurant, as: :call
  defdelegate update_restaurant(id, params), to: UpdateRestaurant, as: :call
  defdelegate create_restaurant_customer(params), to: CreateRestaurantCustomer, as: :call
  defdelegate delete_restaurant_customer(id), to: DeleteRestaurantCustomer, as: :call
  defdelegate get_restaurant_customer(id), to: GetRestaurantCustomer, as: :call
  defdelegate undelete_restaurant_customer(id), to: UndeleteRestaurantCustomer, as: :call
  defdelegate update_restaurant_customer(id, params), to: UpdateRestaurantCustomer, as: :call
  defdelegate create_item(params), to: CreateItem, as: :call
  defdelegate delete_item(id), to: DeleteItem, as: :call
  defdelegate get_item(id), to: GetItem, as: :call
  defdelegate undelete_item(id), to: UndeleteItem, as: :call
  defdelegate update_item(id, params), to: UpdateItem, as: :call
end
