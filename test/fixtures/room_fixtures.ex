defmodule InfoCare.RoomFixtures do
  alias InfoCare.Room
  alias InfoCare.ServiceFixtures

  def room_1(service) do
    %Room{
      service_id: service.id,
      name: "3. SNR TODDLERS",
    }
  end

  def room_2(service) do
    %Room{
      service_id: service.id,
      name: "5. KINDERGARTEN",
    }
  end
end
