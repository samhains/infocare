defmodule InfoCare.ServiceFixtures do
  alias InfoCare.Service

  def service_1 do
    %Service{
      qk_service_id: "317913",
      name: "Piper Central World of Learning",
      email: "pipercentral@worldoflearning.com.au",
      phone_number: "07 4154 2100",
      time_zone: "Australia/Brisbane",
      licensed_capacity:	"75"
    }
  end
end
