defmodule InfoCare.RoomFixtures do
  alias InfoCare.Room
  alias InfoCare.ServiceFixtures

  def room_1(service) do
    %Room{
      qk_room_id: "318251",
      service_id: service.id,
      sync_id: "c6265ed4-1471-e211-a3ad-5ef3fc0d484b",
      name: "3. SNR TODDLERS",
      active: true
    }
  end

  def room_2(service) do
    %Room{
      qk_room_id: "318663",
      service_id: service.id,
      sync_id: "c5265ed4-1471-e211-a3ad-5ef3fc0d484b",
      name: "5. KINDERGARTEN",
      active: true}
  end
end
