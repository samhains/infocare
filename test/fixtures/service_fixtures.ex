defmodule InfoCare.ServiceFixtures do
  alias InfoCare.Service

  def service_1 do
    %Service{
      currency: "NZD",
      email: "russell@info-care.biz",
      ic_service_id: "671",
      capacity: 35,
      max_o2: 15,
      max_u2: 20,
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
      capacity: 23,
      max_o2: 15,
      max_u2: 10,
      name: "First Steps Parnell",
      phone_number: "09 479955",
      post_code: "1311",
      street: "3-92 Churchill Road",
      suburb: "Rothesay Bay"
    }
  end
end
