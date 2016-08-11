defmodule InfoCare.ServiceFixtures do
  alias InfoCare.Service

  def service_1 do
    %Service{
      currency: "NZD",
      email: "russell@info-care.biz",
      ic_service_id: "671",
      licensed_capacity: "35",
      name: "Infocare Test",
      phone_number: "09 4799553",
      post_code: "1311",
      street: "3-92 Churchill Road", suburb: "Rothesay Bay"
    }
  end

  def service_2 do
    %Service{
      currency: "NZD",
      email: "iain@info-ware.biz",
      ic_service_id: "679",
      licensed_capacity: "20",
      name: "First Steps Parnell",
      phone_number: "09 479955",
      post_code: "1311",
      street: "3-92 Churchill Road",
      suburb: "Rothesay Bay"
    }
  end
end
